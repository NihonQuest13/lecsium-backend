# backend/app/api/router.py (CORRIGÉ ET COMPLET AVEC ROADMAP)
from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import StreamingResponse
from fastapi.concurrency import run_in_threadpool
from pydantic import BaseModel, Field
from typing import List, Optional
import faiss
import numpy as np
import json
import os
import shutil
import sys
from pathlib import Path
import logging
from sentence_transformers import SentenceTransformer
from threading import Lock
from contextlib import contextmanager
from collections import defaultdict
import signal
import httpx
import deepl
import asyncio
import tempfile
from google.cloud import storage
from sqlalchemy.orm import Session

# Correction pour l'import relatif si nécessaire
try:
    from ..core.lifespan import ml_models, load_model
    from ..db.connection import get_db
    from ..db.models import User, Novel, Chapter, Friendship, novel_collaborators
    from ..auth.middleware import get_current_user_uid, get_current_user_email, verify_firebase_token
except ImportError:
     sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))
     from app.core.lifespan import ml_models, load_model
     from app.db.connection import get_db
     from app.db.models import User, Novel, Chapter, Friendship, novel_collaborators
     from app.auth.middleware import get_current_user_uid, get_current_user_email, verify_firebase_token


# ===========================================================================
# CONFIGURATION
# ===========================================================================

# Configuration des clés API
api_keys_str = os.environ.get('OPENROUTER_API_KEYS', '')
OPENROUTER_API_KEYS = [key.strip() for key in api_keys_str.split(',') if key.strip()]
DEEPL_API_KEY = os.environ.get('DEEPL_API_KEY', '')

if not OPENROUTER_API_KEYS:
    logging.warning("Aucune clé API OpenRouter n'a été trouvée dans les variables d'environnement (OPENROUTER_API_KEYS).")
if not DEEPL_API_KEY:
    logging.warning("Aucune clé API DeepL n'a été trouvée dans les variables d'environnement (DEEPL_API_KEY).")

# Initialisation du client HTTP asynchrone
client = httpx.AsyncClient(timeout=300.0)

# Configuration du stockage et des verrous
# --- Configuration de Google Cloud Storage ---
# Pour le développement local, on utilise un mock ou on désactive GCS
try:
    storage_client = storage.Client()
    BUCKET_NAME = os.environ.get('STORAGE_PATH', 'exports-lecsium')
except Exception as e:
    logging.warning(f"GCS non disponible en local: {e}. Utilisation du stockage local.")
    storage_client = None
    BUCKET_NAME = None

# Verrous pour un accès concurrentiel sécurisé aux index Faiss
index_locks = defaultdict(Lock)

# Ancienne variable STORAGE_PATH supprimée car on utilise GCS

@contextmanager
def get_index_lock(novel_id: str):
    """Contexte-manager pour verrouiller un index Faiss spécifique."""
    try:
        index_locks[novel_id].acquire()
        yield
    finally:
        index_locks[novel_id].release()

# Traducteur DeepL
try:
    if DEEPL_API_KEY:
        translator = deepl.Translator(DEEPL_API_KEY)
        logging.info("Traducteur DeepL initialisé avec succès.")
    else:
        translator = None
        logging.warning("Traducteur DeepL non initialisé (clé API manquante).")
except Exception as e:
    translator = None
    logging.error(f"Erreur lors de l'initialisation du traducteur DeepL: {e}")

# Rotation des clés API
key_index = 0
key_lock = Lock()

def get_next_api_key():
    """Récupère la première clé API (pas de rotation)."""
    if not OPENROUTER_API_KEYS:
        raise ValueError("Aucune clé API OpenRouter n'est disponible.")
    return OPENROUTER_API_KEYS[0]

router = APIRouter()
logging.info("Routeur API initialisé.")

# ===========================================================================
# MODÈLES DE DONNÉES (Pydantic)
# ===========================================================================

class GenerationRequest(BaseModel):
    prompt: str
    model_id: str
    language: str

class IndexRequest(BaseModel):
    novel_id: str
    chapter_id: str
    content: str

class ContextRequest(BaseModel):
    novel_id: str
    query: str
    top_k: int = 3

class TranslationRequest(BaseModel):
    word: str
    target_lang: str = "FR"

class DeleteRequest(BaseModel):
    novel_id: str

class DeleteChapterRequest(BaseModel):
    novel_id: str
    chapter_id: str

class RoadmapRequest(BaseModel):
    novel_id: str
    title: str
    genre: str
    specifications: str
    language: str
    model_id: Optional[str] = None
    chapters_content: List[str]
    current_roadmap: Optional[str] = None

# ===========================================================================
# FONCTIONS UTILITAIRES (Vector Store)
# ===========================================================================

def get_sentence_transformer() -> SentenceTransformer:
    """Récupère le modèle de transformation de phrases depuis le cache global (lazy loading)."""
    model = ml_models.get("sentence_transformer")
    if model is None:
        logging.info("Modèle non chargé, déclenchement du chargement paresseux.")
        load_model()  # Chargement paresseux
        model = ml_models.get("sentence_transformer")
        if model is None:
            logging.critical("Le modèle de transformation de phrases n'est pas chargé après lazy loading !")
            raise HTTPException(status_code=500, detail="Le service de contexte n'est pas initialisé.")
    return model

# --- NOUVELLES FONCTIONS UTILITAIRES (pour Google Cloud Storage) ---

def get_faiss_blob_path(novel_id: str) -> str:
    """Retourne le chemin *dans* le bucket pour l'index Faiss."""
    return f"{novel_id}/faiss_index.bin"

def get_chapters_blob_path(novel_id: str) -> str:
    """Retourne le chemin *dans* le bucket pour le JSON des chapitres."""
    return f"{novel_id}/chapters.json"

def load_chapters_db(novel_id: str) -> dict:
    """Charge la base de données des chapitres (JSON) depuis GCS."""
    assert storage_client is not None, "GCS storage not available"
    try:
        bucket = storage_client.bucket(BUCKET_NAME)
        blob = bucket.blob(get_chapters_blob_path(novel_id))

        if not blob.exists():
            return {}

        # Télécharger dans un fichier temporaire
        with tempfile.NamedTemporaryFile() as tmp_file:
            blob.download_to_filename(tmp_file.name)
            with open(tmp_file.name, 'r', encoding='utf-8') as f:
                return json.load(f)

    except json.JSONDecodeError:
        logging.error(f"Erreur de décodage JSON pour {novel_id}. Fichier corrompu ?")
        return {}
    except Exception as e:
        logging.error(f"Erreur lors du chargement de chapters.json depuis GCS: {e}")
        return {}

def save_chapters_db(novel_id: str, db: dict):
    """Sauvegarde la base de données des chapitres (JSON) vers GCS."""
    assert storage_client is not None, "GCS storage not available"
    try:
        bucket = storage_client.bucket(BUCKET_NAME)
        blob = bucket.blob(get_chapters_blob_path(novel_id))

        # Écrire dans un fichier temporaire
        with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', delete=False) as tmp_file:
            json.dump(db, tmp_file, ensure_ascii=False, indent=2)
            tmp_file.close() # Fermer pour s'assurer que tout est écrit

            # Uploader le fichier temporaire
            blob.upload_from_filename(tmp_file.name)

        os.unlink(tmp_file.name) # Supprimer le fichier temporaire

    except Exception as e:
        logging.error(f"Erreur d'écriture lors de la sauvegarde de {novel_id} vers GCS: {e}")

# ===========================================================================
# ENDPOINTS - GÉNÉRATION (Stream, Completion, Roadmap)
# ===========================================================================

@router.post("/generate_completion")
async def generate_completion_from_prompt(request: GenerationRequest):
    """Endpoint pour générer une réponse non-streaming."""
    if not OPENROUTER_API_KEYS:
        raise HTTPException(status_code=503, detail="Le service de génération n'est pas configuré (clés manquantes).")
    
    api_key = get_next_api_key()
    logging.info(f"Début de la complétion simple pour le modèle : {request.model_id} (langue: {request.language})")

    try:
        response = await client.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": request.model_id,
                "messages": [{"role": "user", "content": request.prompt}],
                "stream": False,
            },
        )
        response.raise_for_status() 
        data = response.json()
        message = data['choices'][0]['message']
        content = message['content'] if message and 'content' in message else ""

        if not content:
            raise HTTPException(status_code=500, detail="L'IA n'a retourné aucun contenu.")
            
        logging.info(f"Complétion simple terminée pour {request.model_id}.")
        return {"content": content}
        
    except httpx.HTTPStatusError as e:
        error_detail = f"Erreur de l'API OpenRouter ({e.response.status_code}): {e.response.text}"
        logging.error(error_detail)
        raise HTTPException(status_code=e.response.status_code, detail=error_detail)
    except Exception as e:
        logging.error(f"Erreur inattendue lors de la complétion simple: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne du backend: {e}")

async def _stream_generator_with_heartbeat(stream_generator):
    """Wrapper qui ajoute un 'heartbeat' (ping) pour maintenir la connexion."""
    heartbeat_interval = 30
    try:
        stream_iterator = stream_generator.__aiter__()
        while True:
            try:
                chunk = await asyncio.wait_for(stream_iterator.__anext__(), timeout=heartbeat_interval)
                yield chunk
            except StopAsyncIteration:
                logging.info("Heartbeat wrapper: Stream principal terminé.")
                break
            except asyncio.TimeoutError:
                logging.info("Envoi du heartbeat keep-alive...")
                yield f'data: {json.dumps({"type": "ping"})}\n\n'
    except Exception as e:
        logging.error(f"Erreur dans le wrapper de heartbeat: {e}", exc_info=True)
        yield f'data: {json.dumps({"error": f"Erreur interne du wrapper de stream: {e}"})}\n\n'
    finally:
        logging.info("Wrapper de heartbeat terminé.")

async def _stream_generator(prompt: str, model_id: str, language: str):
    """Générateur asynchrone interne pour le streaming."""
    try:
        api_key = get_next_api_key()
        logging.info(f"Début du stream pour le modèle : {model_id} (langue: {language})")
        async with client.stream("POST", "https://openrouter.ai/api/v1/chat/completions", headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}, json={"model": model_id, "messages": [{"role": "user", "content": prompt}], "stream": True}) as response:
            if response.status_code != 200:
                error_content = await response.aread()
                logging.error(f"Erreur API OpenRouter ({response.status_code}): {error_content.decode()}")
                yield f'data: {json.dumps({"error": "Erreur du fournisseur IA", "status_code": response.status_code})}\n\n'
                return
            async for chunk in response.aiter_bytes():
                lines = chunk.decode('utf-8').splitlines()
                for line in lines:
                    if line.startswith("data:"):
                        data_content = line[len("data:"):].strip()
                        if data_content == "[DONE]":
                            yield f'data: [DONE]\n\n'
                            logging.info(f"Stream [DONE] reçu pour {model_id}.")
                        else:
                            try:
                                chunk_data = json.loads(data_content)
                                yield f'data: {json.dumps(chunk_data)}\n\n'
                            except json.JSONDecodeError:
                                logging.warning(f"Ignoré un chunk de stream non-JSON ou partiel: {data_content}")
    except Exception as e:
        logging.error(f"Erreur inattendue dans le stream generator: {e}", exc_info=True)
        yield f'data: {json.dumps({"error": f"Erreur interne du backend: {e}"})}\n\n'
    finally:
        logging.info(f"Stream terminé pour {model_id}.")

@router.post("/generate_chapter_stream")
async def stream_chapter_from_prompt(request: GenerationRequest):
    """Endpoint principal pour générer un chapitre en streaming avec heartbeat."""
    if not OPENROUTER_API_KEYS:
        raise HTTPException(status_code=503, detail="Le service de génération n'est pas configuré.")
    raw_stream = _stream_generator(request.prompt, request.model_id, request.language)
    heartbeat_stream = _stream_generator_with_heartbeat(raw_stream)
    return StreamingResponse(heartbeat_stream, media_type="text/event-stream", headers={'Cache-Control': 'no-cache', 'Connection': 'keep-alive', 'X-Accel-Buffering': 'no'})

@router.post("/generate_roadmap")
async def generate_roadmap_endpoint(request: RoadmapRequest):
    """Génère ou met à jour le résumé de l'histoire (roadmap passé)."""
    logging.info(f"Requête reçue pour générer/màj roadmap pour novel: {request.novel_id}")
    
    roadmap_update_prompt_template = """
Voici le résumé global actuel (la fiche de route) du roman "[NOVEL_TITLE]".
<Fiche de route actuelle>
[CURRENT_ROADMAP]
</Fiche de route actuelle>

Et voici le contenu des 3 derniers chapitres de l'histoire.
<3 derniers chapitres>
[LAST_3_CHAPTERS]
</3 derniers chapitres>

Votre tâche est de **mettre à jour** la fiche de route actuelle en tenant compte des événements des 3 derniers chapitres.
**Important** : Le résumé doit être rédigé dans un **style narratif naturel et fluide**, comme si vous racontiez l'histoire à quelqu'un. Évitez les listes à puces ou le style "notes". Cependant, vous devez **impérativement inclure** les informations suivantes pour le contexte de l'IA :
-   Les noms et prénoms des personnages (si disponibles).
-   Une chronologie claire des événements majeurs.
-   Les noms des lieux importants où se déroule l'action.

Le résultat doit être un **unique paragraphe, nouveau, complet et cohérent**, qui couvre l'histoire depuis son début jusqu'à maintenant.
Votre réponse ne doit contenir que le texte du résumé mis à jour. Ne commencez PAS votre réponse par un titre.
"""
    chapters_text = "\n\n---\n\n".join(request.chapters_content)
    current_roadmap_text = request.current_roadmap if request.current_roadmap else "C'est le début de l'histoire."
    
    prompt = roadmap_update_prompt_template \
        .replace("[NOVEL_TITLE]", request.title) \
        .replace("[CURRENT_ROADMAP]", current_roadmap_text) \
        .replace("[LAST_3_CHAPTERS]", chapters_text)
        
    model_to_use = request.model_id or "qwen/qwen3-235b-a22b:free"
    
    logging.info(f"Appel de l'IA pour la roadmap (modèle: {model_to_use}). Prompt length: {len(prompt)}")
    
    generation_payload = GenerationRequest(prompt=prompt, model_id=model_to_use, language=request.language)
    
    try:
        result = await generate_completion_from_prompt(generation_payload)
        new_roadmap = result.get("content", "").strip()
        if not new_roadmap:
             logging.error(f"La génération de la roadmap pour {request.novel_id} a retourné un résultat vide.")
             raise HTTPException(status_code=500, detail="L'IA n'a pas pu générer le résumé de l'histoire.")
        logging.info(f"Roadmap générée avec succès pour {request.novel_id}. Longueur: {len(new_roadmap)}")
        return {"new_roadmap": new_roadmap}
    except HTTPException as e:
         logging.error(f"Erreur HTTP lors de la génération de la roadmap pour {request.novel_id}: {e.detail}")
         raise e
    except Exception as e:
        logging.error(f"Erreur inattendue lors de la génération de la roadmap pour {request.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la génération du résumé: {e}")

# ===========================================================================
# ENDPOINTS - TRADUCTION
# ===========================================================================

@router.post("/translate")
async def translate_word(request: TranslationRequest):
    """Traduit un mot en utilisant DeepL."""
    if not translator:
        raise HTTPException(status_code=503, detail="Service de traduction non disponible.")
    try:
        result = await run_in_threadpool(translator.translate_text, request.word, target_lang=request.target_lang, source_lang="JA")
        translation = result.text if isinstance(result, deepl.TextResult) else str(result)
        logging.info(f"Traduction DeepL pour '{request.word}': '{translation}'")
        return {"word": request.word, "translation": translation}
    except deepl.DeepLException as e:
        logging.error(f"Erreur de l'API DeepL: {e}")
        raise HTTPException(status_code=502, detail=f"Erreur du service de traduction: {e}")
    except Exception as e:
        logging.error(f"Erreur inattendue lors de la traduction: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne lors de la traduction.")

# ===========================================================================
# ENDPOINTS - VECTOR STORE (Indexation et Recherche)
# ===========================================================================

@router.post("/index_chapter")
async def index_chapter(request: IndexRequest):
    """Indexe ou ré-indexe le contenu d'un chapitre."""
    if not request.novel_id or not request.chapter_id:
        raise HTTPException(status_code=400, detail="novel_id et chapter_id sont requis.")
    if not request.content.strip():
        logging.warning(f"Tentative d'indexation de contenu vide pour {request.novel_id}/{request.chapter_id}. Suppression de l'index...")
        return await delete_chapter_from_index(DeleteChapterRequest(novel_id=request.novel_id, chapter_id=request.chapter_id))
    if storage_client is None:
        raise HTTPException(status_code=503, detail="GCS storage not available")
    try:
        model = get_sentence_transformer()
        encode_task = lambda: model.encode([request.content], show_progress_bar=False)
        embedding = await run_in_threadpool(encode_task)
        embedding = np.array(embedding, dtype=np.float32)

        bucket = storage_client.bucket(BUCKET_NAME)
        index_blob_path = get_faiss_blob_path(request.novel_id)
        index_blob = bucket.blob(index_blob_path)

        with get_index_lock(request.novel_id):
            chapters_db = load_chapters_db(request.novel_id)  # OK, utilise GCS

            # 1. Télécharger l'index existant (s'il existe)
            if index_blob.exists():
                with tempfile.NamedTemporaryFile() as tmp_index:
                    index_blob.download_to_filename(tmp_index.name)
                    index = faiss.read_index(tmp_index.name)
            else:
                index = faiss.IndexIDMap(faiss.IndexFlatL2(embedding.shape[1]))

            # 2. ... (votre logique 'remove_ids' et 'add_with_ids') ...
            d = embedding.shape[1]
            vector_id_to_find = chapters_db.get(request.chapter_id, {}).get('vector_id', -1)
            ids_to_remove = [vector_id_to_find] if vector_id_to_find != -1 else []
            if ids_to_remove:
                try:
                    index.remove_ids(np.array(ids_to_remove, dtype=np.int64))
                except (RuntimeError, ValueError) as e:
                     logging.error(f"Erreur lors de la suppression du vecteur {ids_to_remove} de l'index {request.novel_id}: {e}")
            try: new_vector_id = int(request.chapter_id)
            except ValueError: new_vector_id = hash(request.chapter_id)
            new_vector_id = np.int64(new_vector_id)
            if new_vector_id == -1: new_vector_id = np.int64(hash(request.chapter_id + "_alt"))
            try:
                index.add_with_ids(embedding, np.array([new_vector_id], dtype=np.int64))
            except RuntimeError as e:
                 logging.error(f"Erreur lors de l'ajout du vecteur {new_vector_id} à l'index {request.novel_id}: {e}")
                 raise HTTPException(status_code=500, detail=f"Erreur critique de l'index Faiss: {e}")

            # 3. Sauvegarder le nouvel index dans un fichier temporaire
            with tempfile.NamedTemporaryFile(delete=False) as tmp_index_out:
                faiss.write_index(index, tmp_index_out.name)
                tmp_index_out.close()

                # 4. Uploader le nouvel index vers GCS
                index_blob.upload_from_filename(tmp_index_out.name)

            os.unlink(tmp_index_out.name)  # Nettoyer

            # 5. Sauvegarder la DB des chapitres (qui utilise déjà GCS)
            chapters_db[request.chapter_id] = {'vector_id': int(new_vector_id), 'content': request.content}
            save_chapters_db(request.novel_id, chapters_db)  # OK, utilise GCS

        return {"status": "indexed", "novel_id": request.novel_id, "chapter_id": request.chapter_id, "vector_id": int(new_vector_id)}
    except Exception as e:
        logging.error(f"Erreur lors de l'indexation du chapitre {request.novel_id}/{request.chapter_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de l'indexation: {e}")

@router.post("/get_context")
async def get_context(request: ContextRequest):
    """Récupère les chapitres les plus similaires."""
    if storage_client is None:
        # Mode local: utiliser le stockage local
        try:
            storage_path = Path("storage") / request.novel_id / "faiss_index.bin"
            if not storage_path.exists():
                return {"novel_id": request.novel_id, "similar_chapters_content": []}
            model = get_sentence_transformer()
            encode_task = lambda: model.encode([request.query], show_progress_bar=False)
            query_embedding = await run_in_threadpool(encode_task)
            query_embedding = np.array(query_embedding, dtype=np.float32)
            with get_index_lock(request.novel_id):
                index = faiss.read_index(str(storage_path))
                chapters_db_path = Path("storage") / request.novel_id / "chapters.json"
                if not chapters_db_path.exists():
                    return {"novel_id": request.novel_id, "similar_chapters_content": []}
                with open(chapters_db_path, 'r', encoding='utf-8') as f:
                    chapters_db = json.load(f)
                if not chapters_db: return {"novel_id": request.novel_id, "similar_chapters_content": []}
                # Handle old format where chapters_db is {chapter_id: content} instead of {chapter_id: {'vector_id': int, 'content': str}}
                if isinstance(next(iter(chapters_db.values())), str):
                    # Old format: assume vector_id is int(chapter_id)
                    vector_id_to_chapter_id = {int(k): k for k in chapters_db.keys()}
                    similar_chapters_content = []
                    k = min(request.top_k, index.ntotal)
                    if k == 0: return {"novel_id": request.novel_id, "similar_chapters_content": []}
                    distances, vector_ids = index.search(query_embedding, k)
                    for vid in vector_ids[0]:
                        if vid != -1 and vid in vector_id_to_chapter_id:
                            chapter_id = vector_id_to_chapter_id[vid]
                            similar_chapters_content.append(chapters_db[chapter_id])
                else:
                    # New format
                    vector_id_to_chapter_id = {v['vector_id']: k for k, v in chapters_db.items()}
                    k = min(request.top_k, index.ntotal)
                    if k == 0: return {"novel_id": request.novel_id, "similar_chapters_content": []}
                    distances, vector_ids = index.search(query_embedding, k)
                    similar_chapters_content = [chapters_db[vector_id_to_chapter_id[vid]]['content'] for vid in vector_ids[0] if vid != -1 and vector_id_to_chapter_id.get(vid) in chapters_db]
            return {"novel_id": request.novel_id, "similar_chapters_content": similar_chapters_content}
        except Exception as e:
            logging.error(f"Erreur lors de la récupération du contexte pour {request.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de la recherche de contexte: {e}")
    else:
        # Mode GCS
        bucket = storage_client.bucket(BUCKET_NAME)
        index_blob_path = get_faiss_blob_path(request.novel_id)
        index_blob = bucket.blob(index_blob_path)
        if not index_blob.exists():
            return {"novel_id": request.novel_id, "similar_chapters_content": []}
        try:
            model = get_sentence_transformer()
            encode_task = lambda: model.encode([request.query], show_progress_bar=False)
            query_embedding = await run_in_threadpool(encode_task)
            query_embedding = np.array(query_embedding, dtype=np.float32)
            with get_index_lock(request.novel_id):
                # Télécharger l'index dans un fichier temporaire
                with tempfile.NamedTemporaryFile() as tmp_index:
                    index_blob.download_to_filename(tmp_index.name)
                    index = faiss.read_index(tmp_index.name)
                chapters_db = load_chapters_db(request.novel_id)
                if len(chapters_db) == 0: return {"novel_id": request.novel_id, "similar_chapters_content": []}
                vector_id_to_chapter_id = {v['vector_id']: k for k, v in chapters_db.items()}
                k = min(request.top_k, index.ntotal)
                if k == 0: return {"novel_id": request.novel_id, "similar_chapters_content": []}
                distances, vector_ids = index.search(query_embedding, k)
                similar_chapters_content = [chapters_db[vector_id_to_chapter_id[vid]]['content'] for vid in vector_ids[0] if vid != -1 and vector_id_to_chapter_id.get(vid) in chapters_db]
            return {"novel_id": request.novel_id, "similar_chapters_content": similar_chapters_content}
        except Exception as e:
            logging.error(f"Erreur lors de la récupération du contexte pour {request.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de la recherche de contexte: {e}")

# ===========================================================================
# ENDPOINTS - GESTION DU STOCKAGE
# ===========================================================================

@router.post("/delete_novel_storage")
async def delete_novel_storage(request: DeleteRequest):
    """Supprime l'intégralité du stockage GCS pour un roman."""
    if storage_client is None:
        raise HTTPException(status_code=503, detail="GCS storage not available")
    try:
        bucket = storage_client.bucket(BUCKET_NAME)
        # Lister tous les "fichiers" dans le "dossier" du roman
        blobs_to_delete = list(bucket.list_blobs(prefix=f"{request.novel_id}/"))

        if not blobs_to_delete:
            raise HTTPException(status_code=404, detail="Stockage du roman non trouvé sur GCS.")

        with get_index_lock(request.novel_id):
            # Supprimer les blobs
            bucket.delete_blobs(blobs_to_delete)
            if request.novel_id in index_locks: del index_locks[request.novel_id]

        logging.info(f"Stockage GCS supprimé pour le roman {request.novel_id}")
        return {"status": "deleted", "novel_id": request.novel_id}
    except Exception as e:
        logging.error(f"Erreur lors de la suppression du stockage GCS {request.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la suppression GCS: {e}")

@router.post("/delete_chapter_from_index")
async def delete_chapter_from_index(request: DeleteChapterRequest):
    """Supprime un chapitre spécifique de l'index et de la DB."""
    if storage_client is None:
        raise HTTPException(status_code=503, detail="GCS storage not available")
    bucket = storage_client.bucket(BUCKET_NAME)
    index_blob_path = get_faiss_blob_path(request.novel_id)
    index_blob = bucket.blob(index_blob_path)
    if not index_blob.exists():
        return {"status": "not_found", "novel_id": request.novel_id, "chapter_id": request.chapter_id}
    with get_index_lock(request.novel_id):
        chapters_db = load_chapters_db(request.novel_id)
        if request.chapter_id not in chapters_db:
            return {"status": "chapter_not_in_db", "novel_id": request.novel_id, "chapter_id": request.chapter_id}
        vector_id_to_remove = chapters_db.pop(request.chapter_id, {}).get('vector_id', -1)
        save_chapters_db(request.novel_id, chapters_db)
        if vector_id_to_remove != -1:
            try:
                # Télécharger l'index dans un fichier temporaire
                with tempfile.NamedTemporaryFile() as tmp_index:
                    index_blob.download_to_filename(tmp_index.name)
                    index = faiss.read_index(tmp_index.name)
                index.remove_ids(np.array([vector_id_to_remove], dtype=np.int64))
                # Sauvegarder le nouvel index dans un fichier temporaire
                with tempfile.NamedTemporaryFile(delete=False) as tmp_index_out:
                    faiss.write_index(index, tmp_index_out.name)
                    tmp_index_out.close()
                    # Uploader le nouvel index vers GCS
                    index_blob.upload_from_filename(tmp_index_out.name)
                os.unlink(tmp_index_out.name)  # Nettoyer
                return {"status": "deleted", "novel_id": request.novel_id, "chapter_id": request.chapter_id}
            except (RuntimeError, ValueError) as e:
                logging.error(f"Erreur lors de la suppression du vecteur {vector_id_to_remove} de l'index {request.novel_id}: {e}")
                raise HTTPException(status_code=500, detail=f"Erreur Faiss lors de la suppression: {e}")
    return {"status": "deleted_from_db_only", "novel_id": request.novel_id, "chapter_id": request.chapter_id}

@router.get("/list_indexed_novels")
async def list_indexed_novels():
    """Liste tous les novel_id qui ont un stockage sur GCS ou local."""
    if storage_client is None:
        # Mode local: utiliser le stockage local
        try:
            storage_path = Path("storage")
            if storage_path.exists():
                indexed_novels = [e.name for e in storage_path.iterdir() if e.is_dir() and ((e / "faiss_index.bin").exists() or (e / "chapters.json").exists())]
            else:
                indexed_novels = []
            return {"indexed_novels": indexed_novels}
        except OSError as e:
            logging.error(f"Erreur lors du parcours du dossier de stockage local {storage_path}: {e}")
            raise HTTPException(status_code=500, detail="Erreur interne lors du listage des romans.")
    else:
        # Mode GCS
        try:
            bucket = storage_client.bucket(BUCKET_NAME)
            # Lister tous les "dossiers" (préfixes) dans le bucket
            novel_prefixes = set()
            for blob in bucket.list_blobs():
                if '/' in blob.name:
                    novel_id = blob.name.split('/')[0]
                    novel_prefixes.add(novel_id)
            indexed_novels = list(novel_prefixes)
            return {"indexed_novels": indexed_novels}
        except Exception as e:
            logging.error(f"Erreur lors du listage des romans depuis GCS: {e}")
            raise HTTPException(status_code=500, detail="Erreur interne lors du listage des romans.")

# ===========================================================================
# ENDPOINTS - SYSTÈME (Santé, Racine)
# ===========================================================================

@router.get("/healthz")
async def health_check():
    """Vérification de santé pour les services d'hébergement."""
    return {"status": "ok", "model_loaded": "sentence_transformer" in ml_models}

@router.get("/")
def read_root():
    """Endpoint racine."""
    return {"status": "Nihon Quest Backend Fonctionnel", "version": "1.3"}

# ===========================================================================
# ENDPOINTS - AUTHENTIFICATION
# ===========================================================================

@router.post("/auth/verify-token")
async def verify_token(decoded_token: dict = Depends(verify_firebase_token)):
    """Vérifie et retourne les informations du token Firebase."""
    return {
        "uid": decoded_token.get("uid"),
        "email": decoded_token.get("email"),
        "email_verified": decoded_token.get("email_verified", False),
        "name": decoded_token.get("name"),
        "picture": decoded_token.get("picture")
    }

# ===========================================================================
# ENDPOINTS - NOVELS CRUD
# ===========================================================================

class NovelCreateRequest(BaseModel):
    title: str
    genre: Optional[str] = None
    description: Optional[str] = None

class NovelUpdateRequest(BaseModel):
    title: Optional[str] = None
    genre: Optional[str] = None
    description: Optional[str] = None

class ChapterCreateRequest(BaseModel):
    chapter_number: int
    title: Optional[str] = None
    content: str

@router.get("/novels")
async def get_novels(
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Récupère tous les romans de l'utilisateur connecté."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novels = db.query(Novel).filter(Novel.author_id == user.id).all()
    return {"novels": [
        {
            "id": novel.id,
            "title": novel.title,
            "genre": novel.genre,
            "description": novel.description,
            "created_at": novel.created_at,
            "updated_at": novel.updated_at
        } for novel in novels
    ]}

@router.post("/novels")
async def create_novel(
    request: NovelCreateRequest,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Crée un nouveau roman."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = Novel(
        title=request.title,
        genre=request.genre,
        description=request.description,
        author_id=user.id
    )
    db.add(novel)
    db.commit()
    db.refresh(novel)

    return {
        "id": novel.id,
        "title": novel.title,
        "genre": novel.genre,
        "description": novel.description,
        "created_at": novel.created_at,
        "updated_at": novel.updated_at
    }

@router.get("/novels/{novel_id}")
async def get_novel(
    novel_id: int,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Récupère un roman spécifique."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé")

    chapters = db.query(Chapter).filter(Chapter.novel_id == novel_id).all()
    return {
        "id": novel.id,
        "title": novel.title,
        "genre": novel.genre,
        "description": novel.description,
        "created_at": novel.created_at,
        "updated_at": novel.updated_at,
        "chapters": [
            {
                "id": chapter.id,
                "chapter_number": chapter.chapter_number,
                "title": chapter.title,
                "content": chapter.content,
                "created_at": chapter.created_at,
                "updated_at": chapter.updated_at
            } for chapter in chapters
        ]
    }

@router.put("/novels/{novel_id}")
async def update_novel(
    novel_id: int,
    request: NovelUpdateRequest,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Met à jour un roman."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé")

    if request.title is not None:
        novel.title = request.title
    if request.genre is not None:
        novel.genre = request.genre
    if request.description is not None:
        novel.description = request.description

    db.commit()
    db.refresh(novel)

    return {
        "id": novel.id,
        "title": novel.title,
        "genre": novel.genre,
        "description": novel.description,
        "created_at": novel.created_at,
        "updated_at": novel.updated_at
    }

@router.delete("/novels/{novel_id}")
async def delete_novel(
    novel_id: int,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Supprime un roman."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé")

    db.delete(novel)
    db.commit()

    return {"message": "Roman supprimé avec succès"}

@router.post("/novels/{novel_id}/chapters")
async def create_chapter(
    novel_id: int,
    request: ChapterCreateRequest,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Ajoute un chapitre à un roman."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé")

    chapter = Chapter(
        novel_id=novel_id,
        chapter_number=request.chapter_number,
        title=request.title,
        content=request.content
    )
    db.add(chapter)
    db.commit()
    db.refresh(chapter)

    return {
        "id": chapter.id,
        "chapter_number": chapter.chapter_number,
        "title": chapter.title,
        "content": chapter.content,
        "created_at": chapter.created_at,
        "updated_at": chapter.updated_at
    }

# ===========================================================================
# ENDPOINTS - FRIENDS CRUD
# ===========================================================================

class FriendRequestCreate(BaseModel):
    receiver_email: str

@router.get("/friends")
async def get_friends(
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Récupère la liste des amis de l'utilisateur."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    # Récupérer les amis acceptés (envoyés et reçus)
    sent_requests = db.query(Friendship).filter(
        Friendship.sender_id == user.id,
        Friendship.status == 'accepted'
    ).all()

    received_requests = db.query(Friendship).filter(
        Friendship.receiver_id == user.id,
        Friendship.status == 'accepted'
    ).all()

    friends = []
    for friendship in sent_requests:
        friend = db.query(User).filter(User.id == friendship.receiver_id).first()
        if friend:
            friends.append({
                "id": friend.id,
                "email": friend.email,
                "display_name": friend.display_name
            })

    for friendship in received_requests:
        friend = db.query(User).filter(User.id == friendship.sender_id).first()
        if friend:
            friends.append({
                "id": friend.id,
                "email": friend.email,
                "display_name": friend.display_name
            })

    return {"friends": friends}

@router.post("/friends/send-request")
async def send_friend_request(
    request: FriendRequestCreate,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Envoie une demande d'ami."""
    sender = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not sender:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    receiver = db.query(User).filter(User.email == request.receiver_email).first()
    if not receiver:
        raise HTTPException(status_code=404, detail="Utilisateur destinataire non trouvé")

    if sender.id == receiver.id:
        raise HTTPException(status_code=400, detail="Vous ne pouvez pas vous ajouter vous-même")

    # Vérifier si une demande existe déjà
    existing_request = db.query(Friendship).filter(
        ((Friendship.sender_id == sender.id) & (Friendship.receiver_id == receiver.id)) |
        ((Friendship.sender_id == receiver.id) & (Friendship.receiver_id == sender.id))
    ).first()

    if existing_request:
        raise HTTPException(status_code=400, detail="Une demande d'ami existe déjà")

    friendship = Friendship(sender_id=sender.id, receiver_id=receiver.id)
    db.add(friendship)
    db.commit()
    db.refresh(friendship)

    return {"message": "Demande d'ami envoyée"}

@router.post("/friends/accept-request")
async def accept_friend_request(
    sender_id: int,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Accepte une demande d'ami."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    friendship = db.query(Friendship).filter(
        Friendship.sender_id == sender_id,
        Friendship.receiver_id == user.id,
        Friendship.status == 'pending'
    ).first()

    if not friendship:
        raise HTTPException(status_code=404, detail="Demande d'ami non trouvée")

    friendship.status = 'accepted'  # type: ignore
    db.commit()

    return {"message": "Demande d'ami acceptée"}

# ===========================================================================
# ENDPOINTS - SHARING CRUD
# ===========================================================================

class ShareNovelRequest(BaseModel):
    collaborator_email: str

@router.get("/novels/{novel_id}/collaborators")
async def get_collaborators(
    novel_id: int,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Récupère les collaborateurs d'un roman."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé ou accès non autorisé")

    collaborators = db.query(User).join(novel_collaborators).filter(
        novel_collaborators.c.novel_id == novel_id
    ).all()

    return {"collaborators": [
        {
            "id": collaborator.id,
            "email": collaborator.email,
            "display_name": collaborator.display_name
        } for collaborator in collaborators
    ]}

@router.post("/novels/{novel_id}/share")
async def share_novel(
    novel_id: int,
    request: ShareNovelRequest,
    db: Session = Depends(get_db),
    current_user_uid: str = Depends(get_current_user_uid)
):
    """Partage un roman avec un collaborateur."""
    user = db.query(User).filter(User.firebase_uid == current_user_uid).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")

    novel = db.query(Novel).filter(
        Novel.id == novel_id,
        Novel.author_id == user.id
    ).first()
    if not novel:
        raise HTTPException(status_code=404, detail="Roman non trouvé ou accès non autorisé")

    collaborator = db.query(User).filter(User.email == request.collaborator_email).first()
    if not collaborator:
        raise HTTPException(status_code=404, detail="Collaborateur non trouvé")

    # Vérifier si déjà collaborateur
    existing_collaboration = db.query(novel_collaborators).filter(
        novel_collaborators.c.novel_id == novel_id,
        novel_collaborators.c.user_id == collaborator.id
    ).first()

    if existing_collaboration:
        raise HTTPException(status_code=400, detail="Cet utilisateur est déjà collaborateur")

    # Ajouter le collaborateur
    db.execute(novel_collaborators.insert().values(
        novel_id=novel_id,
        user_id=collaborator.id
    ))
    db.commit()

    return {"message": "Roman partagé avec succès"}
    