# backend/app/api/router.py
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

from ..core.lifespan import ml_models

# ============================================================================
# CONFIGURATION
# ============================================================================

# Configuration des clés API
api_keys_str = os.environ.get('OPENROUTER_API_KEYS', '')
OPENROUTER_API_KEYS = [key.strip() for key in api_keys_str.split(',') if key.strip()]
DEEPL_API_KEY = os.environ.get('DEEPL_API_KEY', '')

if not OPENROUTER_API_KEYS:
    logging.warning("Aucune variable d'environnement OPENROUTER_API_KEYS trouvée. Utilisation des clés locales.")
    OPENROUTER_API_KEYS = [
        'sk-or-v1-58a...',  # Remplacez par vos vraies clés
        'sk-or-v1-8b3...',
        'sk-or-v1-a34...',
    ]

if not DEEPL_API_KEY:
    logging.warning("Aucune variable d'environnement DEEPL_API_KEY trouvée. La traduction échouera.")

CURRENT_API_KEY_INDEX = 0

# Configuration des chemins
if getattr(sys, 'frozen', False):
    BASE_DIR = Path(sys.executable).parent
else:
    BASE_DIR = Path(__file__).parent.parent.parent

STORAGE_DIR = BASE_DIR / "storage"
DIMENSION = 384

# Configuration du logging
log_file_path = BASE_DIR / "backend.log"
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file_path, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

# Router FastAPI
router = APIRouter()

# Verrous pour éviter les accès concurrents
novel_locks = defaultdict(Lock)

# ============================================================================
# MODÈLES DE DONNÉES (Pydantic)
# ============================================================================

class AddChapterPayload(BaseModel):
    novel_id: str
    chapter_text: str

class GetContextPayload(BaseModel):
    novel_id: str
    query: str
    top_k: int = 3

class UpdateChapterPayload(BaseModel):
    novel_id: str
    chapter_id: int
    new_chapter_text: str

class DeleteChapterPayload(BaseModel):
    novel_id: str
    chapter_id: int

class DeleteNovelPayload(BaseModel):
    novel_id: str

class GenerateChapterPayload(BaseModel):
    prompt: str
    model_id: str | None = None
    language: str

class TranslationPayload(BaseModel):
    word: str

class RoadmapPayload(BaseModel):
    novel_title: str
    language: str
    model_id: str | None = None
    current_roadmap: str | None = None
    chapters_content: str

# ============================================================================
# UTILITAIRES
# ============================================================================

@contextmanager
def novel_lock(novel_id: str):
    """Gestionnaire de contexte pour verrouiller l'accès à un roman."""
    lock = novel_locks[novel_id]
    try:
        lock.acquire()
        yield
    finally:
        lock.release()

def get_model() -> SentenceTransformer:
    """Récupère le modèle Sentence Transformer depuis ml_models."""
    if "sentence_transformer" not in ml_models:
        raise HTTPException(
            status_code=503,
            detail="Le modèle d'IA est en cours de chargement, veuillez réessayer dans un instant."
        )
    return ml_models["sentence_transformer"]

def get_novel_paths(novel_id: str) -> dict[str, str]:
    """Retourne les chemins de stockage pour un roman donné."""
    try:
        STORAGE_DIR.mkdir(parents=True, exist_ok=True)
        novel_storage_path = STORAGE_DIR / str(novel_id)
        novel_storage_path.mkdir(exist_ok=True)
        return {
            "storage_path": str(novel_storage_path),
            "index_path": str(novel_storage_path / "faiss_index.bin"),
            "chapters_path": str(novel_storage_path / "chapters.json"),
        }
    except Exception as e:
        logging.error(f"Impossible de créer les chemins pour le roman {novel_id}: {e}")
        raise

def load_novel_data(novel_id: str) -> tuple[faiss.Index, dict]:
    """Charge l'index FAISS et les chapitres d'un roman."""
    paths = get_novel_paths(novel_id)
    index = None
    chapters = {}
    
    # Charger l'index FAISS
    if os.path.exists(paths["index_path"]):
        try:
            index = faiss.read_index(paths["index_path"])
            logging.info(f"Index FAISS chargé pour {novel_id}")
        except Exception as e:
            logging.warning(f"Fichier index FAISS corrompu pour {novel_id}: {e}")
            index = None
    
    # Créer un nouvel index si nécessaire
    if index is None:
        base_index = faiss.IndexFlatIP(DIMENSION)
        index = faiss.IndexIDMap(base_index)
        logging.info(f"Nouvel index FAISS créé pour {novel_id}")
    
    # Charger les chapitres
    if os.path.exists(paths["chapters_path"]):
        try:
            with open(paths["chapters_path"], "r", encoding="utf-8") as f:
                chapters = json.load(f)
            logging.info(f"{len(chapters)} chapitres chargés pour {novel_id}")
        except (json.JSONDecodeError, IOError) as e:
            logging.warning(f"Fichier JSON des chapitres corrompu pour {novel_id}: {e}")
            chapters = {}
    
    return index, chapters

def save_novel_data(novel_id: str, index: faiss.Index, chapters: dict) -> None:
    """Sauvegarde l'index FAISS et les chapitres d'un roman."""
    try:
        paths = get_novel_paths(novel_id)
        faiss.write_index(index, paths["index_path"])
        with open(paths["chapters_path"], "w", encoding="utf-8") as f:
            json.dump(chapters, f, indent=2, ensure_ascii=False)
        logging.info(f"Données sauvegardées avec succès pour le roman {novel_id}")
    except Exception as e:
        logging.error(f"Erreur critique lors de la sauvegarde pour le roman {novel_id}: {e}", exc_info=True)
        raise

def delete_novel_data_sync(novel_id: str) -> None:
    """Supprime toutes les données d'un roman."""
    try:
        paths = get_novel_paths(novel_id)
        if os.path.exists(paths["storage_path"]):
            shutil.rmtree(paths["storage_path"])
            logging.info(f"Dossier supprimé pour le roman {novel_id}")
    except Exception as e:
        logging.error(f"Erreur suppression dossier {paths['storage_path']}: {e}")
        raise

# ============================================================================
# COMMUNICATION AVEC L'API OPENROUTER
# ============================================================================

async def make_api_request(
    prompt: str,
    model_id: str | None,
    language: str,
    system_prompt_key: str = 'default'
) -> str:
    """Effectue une requête à l'API OpenRouter avec gestion des clés multiples."""
    global CURRENT_API_KEY_INDEX
    
    # Prompts système selon le type de requête
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'hiragana': 'あなたは日本語の単語のひらがなの読みを提供するアシスタントです。',
        'roadmap': 'You are an assistant specializing in summarizing novel plots.',
        'default': 'You are a helpful assistant.'
    }
    
    system_prompt = system_prompts.get(system_prompt_key, system_prompts['default'])
    model_to_use = model_id or 'mistralai/mistral-7b-instruct:free'
    
    async with httpx.AsyncClient() as client:
        for i in range(len(OPENROUTER_API_KEYS)):
            api_key = OPENROUTER_API_KEYS[CURRENT_API_KEY_INDEX]
            
            headers = {
                'Authorization': f'Bearer {api_key}',
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://nihonquest.app',
                'X-Title': 'NihonQuest Backend'
            }
            
            body = {
                'model': model_to_use,
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': prompt}
                ],
                'stream': False
            }
            
            try:
                response = await client.post(
                    "https://openrouter.ai/api/v1/chat/completions",
                    headers=headers,
                    json=body,
                    timeout=120
                )
                
                if response.status_code >= 400:
                    logging.error(f"Erreur API ({response.status_code}) avec clé {CURRENT_API_KEY_INDEX}: {response.text}")
                    
                    # Passer à la clé suivante si rate limit ou manque de crédits
                    if response.status_code in [429, 402]:
                        CURRENT_API_KEY_INDEX = (CURRENT_API_KEY_INDEX + 1) % len(OPENROUTER_API_KEYS)
                        logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX}")
                        continue
                    else:
                        response.raise_for_status()
                
                data = response.json()
                return data['choices'][0]['message']['content'].strip()
                
            except httpx.HTTPStatusError:
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise
            except Exception as e:
                logging.error(f"Erreur inattendue avec clé {CURRENT_API_KEY_INDEX}: {e}")
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise
        
        raise HTTPException(status_code=503, detail="Toutes les clés API ont échoué.")

async def stream_openai_response(payload: GenerateChapterPayload):
    """Stream la réponse de l'API OpenRouter pour la génération de chapitres."""
    global CURRENT_API_KEY_INDEX
    
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'default': 'You are a writer who writes novel chapters.'
    }
    
    system_prompt = system_prompts.get(payload.language, system_prompts['default'])
    model_to_use = payload.model_id or 'mistralai/mistral-7b-instruct:free'
    
    async with httpx.AsyncClient() as client:
        for i in range(len(OPENROUTER_API_KEYS)):
            api_key = OPENROUTER_API_KEYS[CURRENT_API_KEY_INDEX]
            
            headers = {
                'Authorization': f'Bearer {api_key}',
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://nihonquest.app',
                'X-Title': 'NihonQuest Novel Generator'
            }
            
            body = {
                'model': model_to_use,
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': payload.prompt}
                ],
                'stream': True
            }
            
            try:
                async with client.stream(
                    "POST",
                    "https://openrouter.ai/api/v1/chat/completions",
                    headers=headers,
                    json=body,
                    timeout=180
                ) as response:
                    if response.status_code >= 400:
                        error_body = await response.aread()
                        logging.error(f"Erreur API ({response.status_code}) avec clé {CURRENT_API_KEY_INDEX}: {error_body.decode()}")
                        
                        if response.status_code in [429, 402]:
                            CURRENT_API_KEY_INDEX = (CURRENT_API_KEY_INDEX + 1) % len(OPENROUTER_API_KEYS)
                            logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX}")
                            continue
                        else:
                            raise httpx.HTTPStatusError(
                                f"Erreur {response.status_code}",
                                request=response.request,
                                response=response
                            )
                    
                    async for chunk in response.aiter_bytes():
                        yield chunk
                    return
                    
            except httpx.HTTPStatusError:
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise
            except Exception as e:
                logging.error(f"Erreur inattendue avec clé {CURRENT_API_KEY_INDEX}: {e}")
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise

# ============================================================================
# ENDPOINTS - TRADUCTION
# ============================================================================

@router.post("/get_translation")
async def get_translation(payload: TranslationPayload):
    """Obtient la lecture hiragana et la traduction française d'un mot japonais."""
    word = payload.word.strip()
    
    if not word:
        raise HTTPException(status_code=400, detail="Le mot ne peut pas être vide.")
    
    reading, translation = None, None
    reading_error, translation_error = None, None
    
    # 1. Obtenir la lecture en hiragana via LLM
    try:
        hiragana_prompt = (
            f"Donne la lecture en hiragana uniquement pour le mot japonais suivant : {word}. "
            "Ne fournis aucune explication, juste les hiraganas."
        )
        reading_result = await make_api_request(
            prompt=hiragana_prompt,
            model_id='mistralai/mistral-7b-instruct:free',
            language='Japonais',
            system_prompt_key='hiragana'
        )
        reading = reading_result.strip().replace('`', '').replace('*', '')
        
        if not reading:
            reading_error = "Lecture non trouvée."
            
    except Exception as e:
        logging.error(f"Erreur lecture pour '{word}': {e}")
        reading_error = "Erreur IA."
    
    # 2. Obtenir la traduction via DeepL
    if DEEPL_API_KEY:
        try:
            translator = deepl.Translator(DEEPL_API_KEY)
            result = translator.translate_text(word, source_lang="JA", target_lang="FR")
            
            # DeepL renvoie toujours une liste, même pour un seul texte
            if isinstance(result, list) and len(result) > 0:
                translation = result[0].text.strip()
                if not translation:
                    translation_error = "Traduction vide."
                    translation = None
            else:
                translation_error = "Traduction non trouvée."
                
        except deepl.DeepLException as e:
            logging.error(f"Erreur DeepL pour '{word}': {e}")
            translation_error = f"Erreur DeepL: {str(e)}"
        except Exception as e:
            logging.error(f"Erreur inattendue DeepL pour '{word}': {e}")
            translation_error = "Erreur DeepL."
    else:
        translation_error = "Clé API DeepL non configurée."
    
    return {
        "reading": reading,
        "translation": translation,
        "readingError": reading_error,
        "translationError": translation_error
    }

# ============================================================================
# ENDPOINTS - GÉNÉRATION
# ============================================================================

@router.post("/generate_chapter_stream")
async def generate_chapter_stream(payload: GenerateChapterPayload):
    """Génère un chapitre en streaming."""
    try:
        return StreamingResponse(
            stream_openai_response(payload),
            media_type="text/event-stream"
        )
    except Exception as e:
        logging.error(f"Erreur critique lors du stream: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne communication IA.")

@router.post("/update_roadmap")
async def update_roadmap(payload: RoadmapPayload):
    """Met à jour la feuille de route (résumé) d'un roman."""
    
    if payload.current_roadmap is None or payload.current_roadmap == "":
        # Création initiale de la feuille de route
        prompt = f'''Voici le contenu des **trois premiers chapitres** du roman "{payload.novel_title}".

<Trois premiers chapitres>
{payload.chapters_content}
</Trois premiers chapitres>

Votre tâche est de créer la **première fiche de route globale**. Le résumé doit être un **style narratif naturel et fluide**. Inclure: noms des personnages, chronologie, lieux. Le résultat doit être un **unique paragraphe cohérent**. Ne commencez PAS par un titre.'''
    else:
        # Mise à jour de la feuille de route existante
        prompt = f'''Voici le résumé global actuel du roman "{payload.novel_title}".

<Fiche de route actuelle>
{payload.current_roadmap}
</Fiche de route actuelle>

Et voici le contenu des 3 derniers chapitres.

<3 derniers chapitres>
{payload.chapters_content}
</3 derniers chapitres>

Votre tâche est de **mettre à jour** la fiche de route. Le résumé doit être un **style narratif naturel et fluide**. Inclure: noms des personnages, chronologie, lieux. Le résultat doit être un **unique paragraphe, nouveau, complet et cohérent**. Ne commencez PAS par un titre.'''
    
    try:
        new_roadmap = await make_api_request(
            prompt=prompt,
            model_id=payload.model_id,
            language=payload.language,
            system_prompt_key='roadmap'
        )
        return {"roadmap": new_roadmap}
    except Exception as e:
        logging.error(f"Erreur màj roadmap pour '{payload.novel_title}': {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur génération roadmap: {e}")

# ============================================================================
# ENDPOINTS - GESTION DES CHAPITRES
# ============================================================================

def _add_chapter_sync(payload: AddChapterPayload) -> dict:
    """Ajoute un chapitre (version synchrone)."""
    model = get_model()
    
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        
        # Encoder le texte du chapitre
        embedding = model.encode([payload.chapter_text])
        faiss.normalize_L2(embedding)
        
        # Ajouter au FAISS index
        new_chapter_id = index.ntotal
        index.add_with_ids(embedding, np.array([new_chapter_id], dtype=np.int64))
        
        # Ajouter aux chapitres
        chapters[str(new_chapter_id)] = payload.chapter_text
        
        # Sauvegarder
        save_novel_data(payload.novel_id, index, chapters)
    
    return {"message": "Chapitre ajouté avec succès."}

@router.post("/add_chapter")
async def add_chapter(payload: AddChapterPayload):
    """Ajoute un nouveau chapitre à un roman."""
    return await run_in_threadpool(_add_chapter_sync, payload)

def _update_chapter_sync(payload: UpdateChapterPayload) -> dict:
    """Met à jour un chapitre (version synchrone)."""
    model = get_model()
    chapter_id_str = str(payload.chapter_id)
    
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        
        if chapter_id_str not in chapters:
            raise FileNotFoundError(f"Chapitre {payload.chapter_id} non trouvé.")
        
        # Mettre à jour le texte
        chapters[chapter_id_str] = payload.new_chapter_text
        
        # Réencoder et mettre à jour dans FAISS
        new_embedding = model.encode([payload.new_chapter_text])
        faiss.normalize_L2(new_embedding)
        
        selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
        index.remove_ids(selector)
        index.add_with_ids(new_embedding, np.array([payload.chapter_id], dtype=np.int64))
        
        # Sauvegarder
        save_novel_data(payload.novel_id, index, chapters)
    
    return {"message": "Chapitre mis à jour avec succès."}

@router.post("/update_chapter")
async def update_chapter(payload: UpdateChapterPayload):
    """Met à jour un chapitre existant."""
    try:
        return await run_in_threadpool(_update_chapter_sync, payload)
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))

def _delete_chapter_sync(payload: DeleteChapterPayload) -> dict:
    """Supprime un chapitre (version synchrone)."""
    model = get_model()
    
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        
        if str(payload.chapter_id) not in chapters:
            raise FileNotFoundError(f"Chapitre {payload.chapter_id} non trouvé.")
        
        # Supprimer du FAISS index et du dict
        selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
        index.remove_ids(selector)
        del chapters[str(payload.chapter_id)]
        
        # Si plus de chapitres, supprimer le roman
        if not chapters:
            delete_novel_data_sync(payload.novel_id)
            return {"message": "Dernier chapitre supprimé. Roman supprimé."}
        
        # Réindexer tous les chapitres pour avoir des IDs consécutifs
        sorted_old_ids = sorted(chapters.keys(), key=int)
        temp_chapters_list = [chapters[old_id] for old_id in sorted_old_ids]
        
        # Réencoder tous les chapitres
        embeddings = model.encode(temp_chapters_list)
        faiss.normalize_L2(embeddings)
        
        # Créer un nouvel index
        new_index = faiss.IndexIDMap(faiss.IndexFlatIP(DIMENSION))
        new_ids = np.arange(len(temp_chapters_list), dtype=np.int64)
        new_index.add_with_ids(embeddings, new_ids)
        
        # Nouveau dictionnaire avec IDs consécutifs
        new_chapters_dict = {str(i): text for i, text in enumerate(temp_chapters_list)}
        
        # Sauvegarder
        save_novel_data(payload.novel_id, new_index, new_chapters_dict)
    
    return {"message": "Chapitre supprimé avec succès."}

@router.post("/delete_chapter")
async def delete_chapter(payload: DeleteChapterPayload):
    """Supprime un chapitre."""
    try:
        return await run_in_threadpool(_delete_chapter_sync, payload)
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))

# ============================================================================
# ENDPOINTS - RECHERCHE SÉMANTIQUE
# ============================================================================

def _get_context_sync(payload: GetContextPayload) -> dict:
    """Recherche sémantique des chapitres similaires (version synchrone)."""
    model = get_model()
    
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        
        if index.ntotal == 0:
            return {"context": []}
        
        # Encoder la requête
        query_vec = model.encode([payload.query])
        faiss.normalize_L2(query_vec)
        
        # Rechercher les k chapitres les plus similaires
        k = min(payload.top_k, index.ntotal)
        _, found_ids = index.search(query_vec, k)
        
        # Récupérer les chapitres
        similar_chapters = [
            chapters[str(i)] for i in found_ids[0] if str(i) in chapters
        ]
    
    return {"context": similar_chapters}

@router.post("/get_context")
async def get_context(payload: GetContextPayload):
    """Recherche les chapitres les plus pertinents pour une requête."""
    return await run_in_threadpool(_get_context_sync, payload)

# ============================================================================
# ENDPOINTS - GESTION DES ROMANS
# ============================================================================

@router.post("/delete_novel")
async def delete_novel(payload: DeleteNovelPayload):
    """Supprime complètement un roman."""
    with novel_lock(payload.novel_id):
        delete_novel_data_sync(payload.novel_id)
    return {"message": "Roman supprimé avec succès."}

@router.get("/list_novels")
async def list_indexed_novels():
    """Liste tous les romans indexés."""
    if not STORAGE_DIR.exists():
        return {"indexed_novels": []}
    
    return {
        "indexed_novels": [
            d.name for d in STORAGE_DIR.iterdir() if d.is_dir()
        ]
    }

# ============================================================================
# ENDPOINTS - SYSTÈME
# ============================================================================

@router.get("/healthz")
async def health_check():
    """Vérification de santé du serveur."""
    return {"status": "ok"}

@router.get("/")
def read_root():
    """Endpoint racine."""
    return {"status": "Backend fonctionnel", "version": "1.0"}

@router.post("/shutdown")
async def shutdown_server():
    """Arrête le serveur (à utiliser avec précaution)."""
    logging.info("Arrêt du serveur demandé.")
    os.kill(os.getpid(), signal.SIGTERM)
    return {"message": "Arrêt du serveur."}