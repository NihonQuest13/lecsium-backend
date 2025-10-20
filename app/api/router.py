# backend/app/api/router.py (CORRIGÉ ET COMPLET)
from fastapi import APIRouter, HTTPException
from fastapi.responses import StreamingResponse
from fastapi.concurrency import run_in_threadpool
from pydantic import BaseModel
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

# Correction pour l'import relatif si nécessaire
try:
    from ..core.lifespan import ml_models
except ImportError:
     sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))
     from app.core.lifespan import ml_models


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
STORAGE_PATH = Path(os.environ.get('STORAGE_PATH', 'storage'))
STORAGE_PATH.mkdir(exist_ok=True)
logging.info(f"Chemin de stockage principal défini sur : {STORAGE_PATH.resolve()}")

# Verrous pour un accès concurrentiel sécurisé aux index Faiss
index_locks = defaultdict(Lock)

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
    """Récupère la prochaine clé API de manière thread-safe."""
    global key_index
    if not OPENROUTER_API_KEYS:
        raise ValueError("Aucune clé API OpenRouter n'est disponible.")
    with key_lock:
        key = OPENROUTER_API_KEYS[key_index]
        key_index = (key_index + 1) % len(OPENROUTER_API_KEYS)
        return key

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

# ===========================================================================
# FONCTIONS UTILITAIRES (Vector Store)
# ===========================================================================

def get_novel_storage_path(novel_id: str) -> Path:
    """Retourne le chemin de stockage spécifique pour un roman."""
    return STORAGE_PATH / novel_id

def get_faiss_index_path(novel_id: str) -> Path:
    """Retourne le chemin du fichier d'index Faiss pour un roman."""
    return get_novel_storage_path(novel_id) / "faiss_index.bin"

def get_chapters_db_path(novel_id: str) -> Path:
    """Retourne le chemin du fichier JSON de métadonnées des chapitres."""
    return get_novel_storage_path(novel_id) / "chapters.json"

def get_sentence_transformer() -> SentenceTransformer:
    """Récupère le modèle de transformation de phrases depuis le cache global."""
    model = ml_models.get("sentence_transformer")
    if model is None:
        logging.critical("Le modèle de transformation de phrases n'est pas chargé !")
        raise HTTPException(status_code=500, detail="Le service de contexte n'est pas initialisé.")
    return model

def load_chapters_db(novel_id: str) -> dict:
    """Charge la base de données des chapitres (ID -> contenu) depuis un JSON."""
    db_path = get_chapters_db_path(novel_id)
    if db_path.exists():
        try:
            with open(db_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except json.JSONDecodeError:
            logging.error(f"Erreur de décodage JSON pour {novel_id}. Fichier corrompu ?")
            return {}
    return {}

def save_chapters_db(novel_id: str, db: dict):
    """Sauvegarde la base de données des chapitres dans un JSON."""
    db_path = get_chapters_db_path(novel_id)
    # --- CETTE LIGNE EST CRUCIALE ---
    get_novel_storage_path(novel_id).mkdir(exist_ok=True)
    try:
        with open(db_path, 'w', encoding='utf-8') as f:
            json.dump(db, f, ensure_ascii=False, indent=2)
    except IOError as e:
        logging.error(f"Erreur d'écriture lors de la sauvegarde de {db_path}: {e}")

# ===========================================================================
# ENDPOINTS - GÉNÉRATION (Stream)
# ===========================================================================

async def _stream_generator(prompt: str, model_id: str, language: str):
    """Générateur asynchrone interne pour le streaming des complétions de chat."""
    try:
        api_key = get_next_api_key()
        logging.info(f"Début du stream pour le modèle : {model_id} (langue: {language})")
        
        async with client.stream(
            "POST",
            "https://openrouter.ai/api/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": model_id,
                "messages": [{"role": "user", "content": prompt}],
                "stream": True,
            },
        ) as response:
            
            if response.status_code != 200:
                error_content = await response.aread()
                logging.error(f"Erreur API OpenRouter ({response.status_code}): {error_content.decode()}")
                yield f'data: {json.dumps({"error": "Erreur du fournisseur IA", "status_code": response.status_code})}\n\n'
                return

            async for chunk in response.aiter_bytes():
                # Note : Un chunk peut contenir plusieurs événements SSE
                lines = chunk.decode('utf-8').splitlines()
                for line in lines:
                    if line.startswith("data:"):
                        data_content = line[len("data:"):].strip()
                        if data_content == "[DONE]":
                            yield f'data: [DONE]\n\n'
                            logging.info(f"Stream [DONE] reçu pour {model_id}.")
                        else:
                            try:
                                # Le chunk est déjà un JSON de l'API, on le transmet
                                chunk_data = json.loads(data_content)
                                yield f'data: {json.dumps(chunk_data)}\n\n'
                            except json.JSONDecodeError:
                                logging.warning(f"Ignoré un chunk de stream non-JSON ou partiel: {data_content}")
                    elif line.strip():
                        logging.debug(f"Ligne de stream non-data ignorée: {line}")

    except httpx.ConnectError as e:
        logging.error(f"Erreur de connexion à OpenRouter: {e}")
        yield f'data: {json.dumps({"error": f"Erreur de connexion au service IA: {e}"})}\n\n'
    except httpx.ReadTimeout as e:
        logging.error(f"Timeout lors de la lecture du stream OpenRouter: {e}")
        yield f'data: {json.dumps({"error": f"Timeout du service IA: {e}"})}\n\n'
    except Exception as e:
        logging.error(f"Erreur inattendue dans le stream generator: {e}", exc_info=True)
        yield f'data: {json.dumps({"error": f"Erreur interne du backend: {e}"})}\n\n'
    finally:
        logging.info(f"Stream terminé pour {model_id}.")

# --- DÉBUT DE LA MODIFICATION HEARTBEAT ---

# ===========================================================================
# ENDPOINTS - GÉNÉRATION (Simple Completion/Planification)
# ===========================================================================

@router.post("/generate_completion")
async def generate_completion_from_prompt(request: GenerationRequest):
    """
    Endpoint pour générer une réponse non-streaming (utile pour la planification/résumé).
    """
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
                "stream": False,  # Non-streaming
            },
        )
        
        # Lève une HTTPException si le code est >= 400
        response.raise_for_status() 

        # Le corps de la réponse est un JSON standard de l'API OpenRouter
        data = response.json()
        
        # Extrait le contenu de la première réponse
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
    """
    Wrapper qui ajoute un 'heartbeat' (ping) à un générateur de stream
    pour maintenir la connexion active à travers les proxys.
    """
    heartbeat_interval = 30  # Envoyer un ping toutes les 30 secondes
    
    try:
        # Crée un itérateur asynchrone à partir du générateur
        stream_iterator = stream_generator.__aiter__()
        
        while True:
            try:
                # Tente de récupérer le prochain morceau du stream IA
                # avec un délai d'attente
                chunk = await asyncio.wait_for(
                    stream_iterator.__anext__(),
                    timeout=heartbeat_interval
                )
                yield chunk
                
            except StopAsyncIteration:
                # Le stream de l'IA est terminé normally
                logging.info("Heartbeat wrapper: Stream principal terminé.")
                break
            except asyncio.TimeoutError:
                # L'IA n'a rien envoyé depuis 'heartbeat_interval' secondes.
                # Envoyons un 'ping' pour garder la connexion ouverte.
                logging.info("Envoi du heartbeat keep-alive...")
                yield f'data: {json.dumps({"type": "ping"})}\n\n'
            
    except Exception as e:
        logging.error(f"Erreur dans le wrapper de heartbeat: {e}", exc_info=True)
        yield f'data: {json.dumps({"error": f"Erreur interne du wrapper de stream: {e}"})}\n\n'
    finally:
        logging.info("Wrapper de heartbeat terminé.")

@router.post("/generate_chapter_stream")
async def stream_chapter_from_prompt(request: GenerationRequest):
    """
    Endpoint principal pour générer un chapitre en streaming.
    Utilise maintenant un wrapper de heartbeat pour la stabilité.
    """
    if not OPENROUTER_API_KEYS:
        raise HTTPException(status_code=503, detail="Le service de génération n'est pas configuré (clés manquantes).")
        
    model_to_use = request.model_id
    
    # 1. Créer le générateur de stream IA brut
    raw_stream = _stream_generator(request.prompt, model_to_use, request.language)
    
    # 2. L'envelopper dans le générateur de heartbeat
    heartbeat_stream = _stream_generator_with_heartbeat(raw_stream)

    # 3. Renvoyer la StreamingResponse avec les en-têtes cruciaux
    return StreamingResponse(
        heartbeat_stream,
        media_type="text/event-stream",
        headers={
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'X-Accel-Buffering': 'no' # Important pour désactiver le buffering de Nginx/proxys
        }
    )

# --- FIN DE LA MODIFICATION HEARTBEAT ---


# ===========================================================================
# ENDPOINTS - TRADUCTION
# ===========================================================================

@router.post("/translate")
async def translate_word(request: TranslationRequest):
    """Traduit un mot en utilisant DeepL."""
    if not translator:
        logging.warning("Tentative de traduction alors que le service DeepL n'est pas initialisé.")
        raise HTTPException(status_code=503, detail="Service de traduction non disponible (clé API manquante).")
    
    try:
        # Utiliser run_in_threadpool car la bibliothèque DeepL est synchrone
        result = await run_in_threadpool(
            translator.translate_text,
            request.word,
            target_lang=request.target_lang,
            source_lang="JA"
        )
        
        # Le service DeepL peut retourner plusieurs traductions, nous prenons la première.
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
    
    # Valider les données d'entrée
    if not request.novel_id or not request.chapter_id:
        raise HTTPException(status_code=400, detail="novel_id et chapter_id sont requis.")
    
    # Éviter d'indexer du contenu vide
    if not request.content.strip():
        logging.warning(f"Tentative d'indexation de contenu vide pour {request.novel_id}/{request.chapter_id}. Suppression de l'index...")
        # Si le contenu est vide, on le supprime de l'index
        return await delete_chapter_from_index(DeleteChapterRequest(novel_id=request.novel_id, chapter_id=request.chapter_id))

    try:
        model = get_sentence_transformer()
        
        # Utiliser run_in_threadpool pour l'encodage (calcul intensif)
        embedding = await run_in_threadpool(model.encode, [request.content])
        embedding = np.array(embedding, dtype=np.float32)
        
        index_path = get_faiss_index_path(request.novel_id)
        db_path = get_chapters_db_path(request.novel_id)
        
        # --- ⬇️ DÉBUT DE LA CORRECTION ERREUR 500 ⬇️ ---
        # On s'assure que le dossier de stockage du roman existe AVANT
        # de tenter d'écrire le fichier d'index Faiss.
        novel_storage_path = get_novel_storage_path(request.novel_id)
        novel_storage_path.mkdir(exist_ok=True)
        # --- ⬆️ FIN DE LA CORRECTION ERREUR 500 ⬆️ ---

        with get_index_lock(request.novel_id):
            chapters_db = load_chapters_db(request.novel_id)
            
            # Gérer la dimension de l'embedding
            d = embedding.shape[1]
            
            vector_id_to_find = -1
            ids_to_remove = []
            
            # Vérifier si ce chapitre (ou un ancien ID) existe déjà
            if request.chapter_id in chapters_db:
                vector_id_to_find = chapters_db[request.chapter_id]['vector_id']
            
            if index_path.exists():
                try:
                    index = faiss.read_index(str(index_path))
                    if index.d != d:
                        logging.warning(f"La dimension de l'index ({index.d}) ne correspond pas à l'embedding ({d}). Ré-indexation forcée.")
                        raise RuntimeError("Dimension mismatch") # <-- CORRIGÉ
                        
                    if vector_id_to_find != -1:
                        ids_to_remove.append(vector_id_to_find)
                        
                except (RuntimeError, AssertionError) as e: # <-- CORRIGÉ
                    logging.warning(f"Impossible de charger l'index Faiss {index_path} (Erreur: {e}). Création d'un nouvel index.")
                    index = faiss.IndexIDMap(faiss.IndexFlatL2(d))
            else:
                logging.info(f"Aucun index Faiss trouvé pour {request.novel_id}. Création d'un nouvel index.")
                index = faiss.IndexIDMap(faiss.IndexFlatL2(d))

            # Supprimer l'ancien vecteur si existant
            if ids_to_remove:
                try:
                    # --- CORRECTION FAISS ---
                    # Utiliser IDSelectorBatch pour la suppression
                    selector = faiss.IDSelectorBatch(np.array(ids_to_remove, dtype=np.int64))
                    index.remove_ids(selector)
                    # --- FIN CORRECTION ---
                    
                    logging.info(f"Ancien vecteur (ID: {ids_to_remove}) supprimé de l'index pour {request.novel_id}.")
                except RuntimeError as e: # <-- CORRIGÉ
                     logging.error(f"Erreur lors de la suppression du vecteur {ids_to_remove} de l'index {request.novel_id}: {e}")

            # Ajouter le nouveau vecteur
            # Utiliser un hash stable de l'ID string, converti en entier 64 bits puis casté.
            # Cela évite les collisions si l'ID n'est pas un simple entier.
            try:
                # Tenter une conversion directe en int pour les IDs numériques (plus rapide)
                new_vector_id = int(request.chapter_id)
            except ValueError:
                # Si non-numérique, utiliser un hash
                new_vector_id = hash(request.chapter_id)
            
            # Faiss utilise des int64 pour les IDs
            new_vector_id = np.int64(new_vector_id)
            # S'assurer que l'ID n'est pas -1 (réservé par Faiss)
            if new_vector_id == -1:
                new_vector_id = np.int64(hash(request.chapter_id + "_alt"))

            
            try:
                index.add_with_ids(embedding, np.array([new_vector_id], dtype=np.int64))
            except RuntimeError as e: # <-- CORRIGÉ
                 logging.error(f"Erreur lors de l'ajout du vecteur {new_vector_id} à l'index {request.novel_id}: {e}")
                 # Tentative de suppression en cas d'échec d'ajout (ex: ID déjà existant)
                 try:
                     # --- CORRECTION FAISS ---
                     selector = faiss.IDSelectorBatch(np.array([new_vector_id], dtype=np.int64))
                     index.remove_ids(selector)
                     # --- FIN CORRECTION ---
                     index.add_with_ids(embedding, np.array([new_vector_id], dtype=np.int64))
                     logging.info(f"Ajout réussi après suppression forcée pour {new_vector_id}.")
                 except Exception as e_retry:
                     logging.critical(f"Échec critique de l'ajout à l'index Faiss pour {request.novel_id}: {e_retry}")
                     raise HTTPException(status_code=500, detail=f"Erreur critique de l'index Faiss: {e_retry}")

            # Sauvegarder l'index et la DB
            # Le dossier est maintenant garanti d'exister grâce à la correction ci-dessus
            faiss.write_index(index, str(index_path)) 
            
            chapters_db[request.chapter_id] = {
                'vector_id': int(new_vector_id), # Stocker en tant qu'int natif dans le JSON
                'content': request.content # Stocker le contenu pour la récupération
            }
            # save_chapters_db crée aussi le dossier, mais c'est ok de l'appeler à nouveau
            save_chapters_db(request.novel_id, chapters_db)

            logging.info(f"Chapitre {request.chapter_id} indexé avec succès pour {request.novel_id} (Vector ID: {new_vector_id}).")
            
        return {"status": "indexed", "novel_id": request.novel_id, "chapter_id": request.chapter_id, "vector_id": int(new_vector_id)}

    except Exception as e:
        logging.error(f"Erreur lors de l'indexation du chapitre {request.novel_id}/{request.chapter_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de l'indexation: {e}")

@router.post("/get_context")
async def get_context(request: ContextRequest):
    """Récupère les chapitres les plus similaires (contexte) pour une requête donnée."""
    
    index_path = get_faiss_index_path(request.novel_id)
    db_path = get_chapters_db_path(request.novel_id)
    
    if not index_path.exists() or not db_path.exists():
        logging.warning(f"Recherche de contexte annulée pour {request.novel_id}: index ou DB introuvable.")
        return {"novel_id": request.novel_id, "similar_chapters_content": []}

    try:
        model = get_sentence_transformer()
        
        # Encoder la requête
        query_embedding = await run_in_threadpool(model.encode, [request.query])
        query_embedding = np.array(query_embedding, dtype=np.float32)

        with get_index_lock(request.novel_id):
            try:
                index = faiss.read_index(str(index_path))
            except RuntimeError as e: # <-- CORRIGÉ
                logging.error(f"Impossible de charger l'index Faiss {index_path} lors de la recherche: {e}")
                raise HTTPException(status_code=500, detail="Erreur de chargement de l'index de contexte.")

            chapters_db = load_chapters_db(request.novel_id)
            if not chapters_db:
                 logging.warning(f"Recherche de contexte pour {request.novel_id} mais la DB des chapitres est vide.")
                 return {"novel_id": request.novel_id, "similar_chapters_content": []}
            
            # Mapper les vector_id vers les chapter_id
            vector_id_to_chapter_id = {v['vector_id']: k for k, v in chapters_db.items()}
            
            # S'assurer que top_k ne dépasse pas le nombre d'éléments dans l'index
            k = min(request.top_k, index.ntotal)
            
            if k == 0:
                logging.info(f"Recherche de contexte pour {request.novel_id}: index vide (ntotal=0).")
                return {"novel_id": request.novel_id, "similar_chapters_content": []}

            # Effectuer la recherche
            distances, vector_ids = index.search(query_embedding, k)
            
            similar_chapters_content = []
            if vector_ids.size > 0:
                for vector_id in vector_ids[0]:
                    if vector_id == -1: # Résultat invalide de Faiss
                        continue
                    
                    chapter_id = vector_id_to_chapter_id.get(vector_id)
                    if chapter_id and chapter_id in chapters_db:
                        similar_chapters_content.append(chapters_db[chapter_id]['content'])
                    else:
                        logging.warning(f"Vector ID {vector_id} trouvé dans Faiss mais non mappé dans la DB JSON pour {request.novel_id}.")

        logging.info(f"Recherche de contexte pour {request.novel_id} (top_k={k}) a retourné {len(similar_chapters_content)} résultats.")
        return {"novel_id": request.novel_id, "similar_chapters_content": similar_chapters_content}

    except Exception as e:
        logging.error(f"Erreur lors de la récupération du contexte pour {request.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la recherche de contexte: {e}")

# ===========================================================================
# ENDPOINTS - GESTION DU STOCKAGE
# ===========================================================================

@router.post("/delete_novel_storage")
async def delete_novel_storage(request: DeleteRequest):
    """Supprime l'intégralité du stockage (index et DB) pour un roman."""
    
    novel_path = get_novel_storage_path(request.novel_id)
    if not novel_path.exists():
        logging.warning(f"Tentative de suppression du stockage pour {request.novel_id}, mais le dossier n'existe pas.")
        raise HTTPException(status_code=404, detail="Stockage du roman non trouvé.")

    try:
        with get_index_lock(request.novel_id):
            # Utiliser run_in_threadpool pour les opérations de fichiers bloquantes
            await run_in_threadpool(shutil.rmtree, novel_path)
            
            # Nettoyer le verrou de l'index
            if request.novel_id in index_locks:
                del index_locks[request.novel_id]
                
        logging.info(f"Stockage pour le roman {request.novel_id} supprimé avec succès.")
        return {"status": "deleted", "novel_id": request.novel_id}
        
    except OSError as e:
        logging.error(f"Erreur d'OS lors de la suppression de {novel_path}: {e}")
        raise HTTPException(status_code=500, detail=f"Erreur lors de la suppression des fichiers du roman: {e}")
    except Exception as e:
        logging.error(f"Erreur inattendue lors de la suppression du stockage {request.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la suppression du stockage: {e}")

@router.post("/delete_chapter_from_index")
async def delete_chapter_from_index(request: DeleteChapterRequest):
    """Supprime un chapitre spécifique de l'index Faiss et de la DB JSON."""
    
    index_path = get_faiss_index_path(request.novel_id)
    db_path = get_chapters_db_path(request.novel_id)
    
    if not index_path.exists() or not db_path.exists():
        logging.warning(f"Tentative de suppression de chapitre {request.chapter_id} pour {request.novel_id}, mais index/DB introuvable.")
        return {"status": "not_found", "novel_id": request.novel_id, "chapter_id": request.chapter_id}

    vector_id_to_remove = -1
    
    with get_index_lock(request.novel_id):
        chapters_db = load_chapters_db(request.novel_id)
        
        if request.chapter_id not in chapters_db:
            logging.warning(f"Chapitre {request.chapter_id} non trouvé dans la DB JSON de {request.novel_id} lors de la suppression.")
            return {"status": "chapter_not_in_db", "novel_id": request.novel_id, "chapter_id": request.chapter_id}
            
        vector_id_to_remove = chapters_db[request.chapter_id].get('vector_id', -1)
        
        # 1. Supprimer de la DB JSON
        del chapters_db[request.chapter_id]
        save_chapters_db(request.novel_id, chapters_db)
        
        # 2. Supprimer de l'index Faiss
        if vector_id_to_remove != -1:
            try:
                index = faiss.read_index(str(index_path))
                
                # --- CORRECTION FAISS ---
                vector_id_np = np.array([vector_id_to_remove], dtype=np.int64)
                selector = faiss.IDSelectorBatch(vector_id_np)
                index.remove_ids(selector)
                # --- FIN CORRECTION ---
                
                faiss.write_index(index, str(index_path))
                logging.info(f"Chapitre {request.chapter_id} (Vector ID: {vector_id_to_remove}) supprimé de Faiss et JSON pour {request.novel_id}.")
                
                return {"status": "deleted", "novel_id": request.novel_id, "chapter_id": request.chapter_id}
                
            except RuntimeError as e: # <-- CORRIGÉ
                logging.error(f"Erreur lors de la suppression du vecteur {vector_id_to_remove} de l'index {request.novel_id}: {e}. DB JSON mise à jour, mais l'index peut être désynchronisé.")
                raise HTTPException(status_code=500, detail=f"Erreur Faiss lors de la suppression du chapitre: {e}")
        else:
             logging.warning(f"Chapitre {request.chapter_id} supprimé de la DB JSON, mais aucun vector_id n'était associé.")
             return {"status": "deleted_from_db_only", "novel_id": request.novel_id, "chapter_id": request.chapter_id}

@router.get("/list_indexed_novels")
async def list_indexed_novels():
    """Liste tous les novel_id qui ont un stockage (dossier) sur le disque."""
    indexed_novels = []
    try:
        for entry in STORAGE_PATH.iterdir():
            if entry.is_dir():
                # On vérifie si un index ou une db existe pour être plus précis
                if (entry / "faiss_index.bin").exists() or (entry / "chapters.json").exists():
                    indexed_novels.append(entry.name)
        logging.info(f"Liste des romans indexés: {indexed_novels}")
    except OSError as e:
        logging.error(f"Erreur lors du parcours du dossier de stockage {STORAGE_PATH}: {e}")
        raise HTTPException(status_code=500, detail="Erreur interne lors du listage des romans.")

    return {"indexed_novels": indexed_novels}

# ===========================================================================
# ENDPOINTS - SYSTÈME (Santé, Racine)
# ===========================================================================

@router.get("/healthz")
async def health_check():
    """Vérification de santé simple pour les services d'hébergement."""
    model_loaded = "sentence_transformer" in ml_models
    logging.debug(f"Health check: Modèle ML chargé: {model_loaded}")
    return {"status": "ok", "model_loaded": model_loaded}

@router.get("/")
def read_root():
    """Endpoint racine, retourne un statut simple."""
    logging.info("Accès à l'endpoint racine.")
    return {"status": "Nihon Quest Backend Fonctionnel", "version": "1.2"} # Version mise à jour