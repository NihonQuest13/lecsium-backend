# backend/app/api/router.py
from fastapi import APIRouter, HTTPException, Request
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

from ..core.lifespan import ml_models

# --- CONFIGURATION DE SÉCURITÉ : LECTURE DES CLÉS API ---
# On lit la variable d'environnement que Render nous donne.
# Si elle n'existe pas (pour le test local), on utilise une liste de secours.
api_keys_str = os.environ.get('OPENROUTER_API_KEYS', '')
OPENROUTER_API_KEYS = [key.strip() for key in api_keys_str.split(',') if key.strip()]

CURRENT_API_KEY_INDEX = 0

# --- Le reste du fichier est identique jusqu'à la fin ---
router = APIRouter()

if getattr(sys, 'frozen', False):
    BASE_DIR = Path(sys.executable).parent
else:
    BASE_DIR = Path(__file__).parent.parent.parent

STORAGE_DIR = BASE_DIR / "storage"
DIMENSION = 384

log_file_path = BASE_DIR / "backend.log"
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file_path, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

novel_locks = defaultdict(Lock)

@contextmanager
def novel_lock(novel_id: str):
    lock = novel_locks[novel_id]
    logging.debug(f"Tentative d'acquisition du verrou pour le roman {novel_id}...")
    lock.acquire()
    logging.debug(f"Verrou acquis pour le roman {novel_id}.")
    try:
        yield
    finally:
        lock.release()
        logging.debug(f"Verrou libéré pour le roman {novel_id}.")


def get_model():
    if "sentence_transformer" not in ml_models:
        raise HTTPException(status_code=503, detail="Le modèle d'IA est en cours de chargement, veuillez réessayer dans un instant.")
    return ml_models["sentence_transformer"]

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
    model_id: str | None
    language: str

def get_novel_paths(novel_id: str):
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

def load_novel_data(novel_id: str):
    paths = get_novel_paths(novel_id)
    index = None
    chapters = {}

    if os.path.exists(paths["index_path"]):
        try:
            index = faiss.read_index(paths["index_path"])
        except Exception as e:
            logging.warning(f"Fichier index FAISS corrompu ou illisible pour {novel_id}: {e}. Un nouvel index sera créé.")
            index = None

    if index is None:
        base_index = faiss.IndexFlatIP(DIMENSION)
        index = faiss.IndexIDMap(base_index)
        
    if os.path.exists(paths["chapters_path"]):
        try:
            with open(paths["chapters_path"], "r", encoding="utf-8") as f:
                chapters = json.load(f)
        except (json.JSONDecodeError, IOError) as e:
            logging.warning(f"Fichier JSON des chapitres corrompu pour {novel_id}: {e}. Le fichier sera traité comme vide.")
            chapters = {}
            
    return index, chapters

def save_novel_data(novel_id: str, index: faiss.Index, chapters: dict):
    try:
        paths = get_novel_paths(novel_id)
        faiss.write_index(index, paths["index_path"])
        with open(paths["chapters_path"], "w", encoding="utf-8") as f:
            json.dump(chapters, f, indent=2, ensure_ascii=False)
        logging.info(f"Données sauvegardées avec succès pour le roman {novel_id}.")
    except Exception as e:
        logging.error(f"Erreur critique lors de la sauvegarde des données pour le roman {novel_id}: {e}", exc_info=True)
        raise

async def stream_openai_response(payload: GenerateChapterPayload):
    global CURRENT_API_KEY_INDEX
    
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'Anglais': 'You are a writer who writes novel chapters based on the specified conditions. Follow the instructions strictly.',
        'default': 'You are a writer who writes novel chapters based on the specified conditions. Follow the instructions strictly.'
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
                'X-Title': 'NihonQuest Novel Generator',
            }
            body = {
                'model': model_to_use,
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': payload.prompt},
                ],
                'stream': True,
            }

            try:
                async with client.stream("POST", "https://openrouter.ai/api/v1/chat/completions", headers=headers, json=body, timeout=180) as response:
                    if response.status_code >= 400:
                        error_body = await response.aread()
                        logging.error(f"Erreur API ({response.status_code}) avec la clé index {CURRENT_API_KEY_INDEX}: {error_body.decode()}")
                        if response.status_code == 429 or response.status_code == 402:
                            logging.warning("Quota atteint. Essai de la clé suivante.")
                            CURRENT_API_KEY_INDEX = (CURRENT_API_KEY_INDEX + 1) % len(OPENROUTER_API_KEYS)
                            continue
                        else:
                            raise httpx.HTTPStatusError(f"Erreur {response.status_code}", request=response.request, response=response)

                    async for chunk in response.aiter_bytes():
                        yield chunk
                    return 
            
            except httpx.HTTPStatusError as e:
                logging.error(f"Erreur HTTPStatusError non gérable avec la clé index {CURRENT_API_KEY_INDEX}")
                if i == len(OPENROUTER_API_KEYS) - 1: raise 
            except Exception as e:
                 logging.error(f"Erreur inattendue avec la clé index {CURRENT_API_KEY_INDEX}: {e}")
                 if i == len(OPENROUTER_API_KEYS) - 1: raise

@router.post("/generate_chapter_stream")
async def generate_chapter_stream(payload: GenerateChapterPayload):
    try:
        return StreamingResponse(stream_openai_response(payload), media_type="text/event-stream")
    except Exception as e:
        logging.error(f"Erreur critique lors de la génération du stream: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de la communication avec l'IA.")

def _add_chapter_sync(payload: AddChapterPayload):
    model = get_model()
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        embedding = model.encode([payload.chapter_text])
        faiss.normalize_L2(embedding)
        new_chapter_id = index.ntotal
        index.add_with_ids(embedding, np.array([new_chapter_id], dtype=np.int64))
        chapters[str(new_chapter_id)] = payload.chapter_text
        save_novel_data(payload.novel_id, index, chapters)
    return {"message": "Chapitre ajouté."}

@router.post("/add_chapter")
async def add_chapter(payload: AddChapterPayload):
    return await run_in_threadpool(_add_chapter_sync, payload)

def _get_context_sync(payload: GetContextPayload):
    model = get_model()
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        if index.ntotal == 0: return {"context": []}
        query_vec = model.encode([payload.query])
        faiss.normalize_L2(query_vec)
        k = min(payload.top_k, index.ntotal)
        _, found_ids = index.search(query_vec, k)
        similar_chapters = [chapters[str(i)] for i in found_ids[0] if str(i) in chapters]
    return {"context": similar_chapters}

@router.post("/get_context")
async def get_context(payload: GetContextPayload):
    return await run_in_threadpool(_get_context_sync, payload)

def _update_chapter_sync(payload: UpdateChapterPayload):
    model = get_model()
    chapter_id_str = str(payload.chapter_id)
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        if chapter_id_str not in chapters: raise FileNotFoundError()
        chapters[chapter_id_str] = payload.new_chapter_text
        new_embedding = model.encode([payload.new_chapter_text])
        faiss.normalize_L2(new_embedding)
        selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
        index.remove_ids(selector)
        index.add_with_ids(new_embedding, np.array([payload.chapter_id], dtype=np.int64))
        save_novel_data(payload.novel_id, index, chapters)
    return {"message": "Chapitre mis à jour."}

@router.post("/update_chapter")
async def update_chapter(payload: UpdateChapterPayload):
    try:
        return await run_in_threadpool(_update_chapter_sync, payload)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Chapitre non trouvé.")

def _delete_chapter_sync(payload: DeleteChapterPayload):
    model = get_model()
    chapter_id_to_delete = payload.chapter_id
    with novel_lock(payload.novel_id):
        index, chapters = load_novel_data(payload.novel_id)
        if str(chapter_id_to_delete) not in chapters: raise FileNotFoundError()
        selector = faiss.IDSelectorBatch(np.array([chapter_id_to_delete], dtype=np.int64))
        index.remove_ids(selector)
        del chapters[str(chapter_id_to_delete)]
        if not chapters:
            delete_novel_data_sync(payload.novel_id)
            return {"message": "Dernier chapitre supprimé, roman effacé."}
        
        sorted_old_ids = sorted(chapters.keys(), key=int)
        temp_chapters_list = [chapters[old_id] for old_id in sorted_old_ids]
        
        if temp_chapters_list:
            embeddings = model.encode(temp_chapters_list)
            faiss.normalize_L2(embeddings)
            new_index = faiss.IndexIDMap(faiss.IndexFlatIP(DIMENSION))
            new_ids = np.arange(len(temp_chapters_list), dtype=np.int64)
            new_index.add_with_ids(embeddings, new_ids)
            new_chapters_dict = {str(i): text for i, text in enumerate(temp_chapters_list)}
            save_novel_data(payload.novel_id, new_index, new_chapters_dict)
        else:
            delete_novel_data_sync(payload.novel_id)
    return {"message": "Chapitre supprimé et ré-indexé."}

@router.post("/delete_chapter")
async def delete_chapter(payload: DeleteChapterPayload):
    try:
        return await run_in_threadpool(_delete_chapter_sync, payload)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Chapitre non trouvé.")

def delete_novel_data_sync(novel_id: str):
    try:
        paths = get_novel_paths(novel_id)
        novel_storage_path = paths["storage_path"]
        if os.path.exists(novel_storage_path):
            shutil.rmtree(novel_storage_path)
    except Exception as e:
        logging.error(f"Erreur lors de la suppression du dossier {novel_storage_path}: {e}")
        raise

@router.post("/delete_novel")
async def delete_novel(payload: DeleteNovelPayload):
    with novel_lock(payload.novel_id):
        delete_novel_data_sync(payload.novel_id)
    return {"message": "Données du roman supprimées."}

@router.get("/list_novels")
async def list_indexed_novels():
    if not STORAGE_DIR.exists(): return {"indexed_novels": []}
    return {"indexed_novels": [d.name for d in STORAGE_DIR.iterdir() if d.is_dir()]}

@router.post("/shutdown")
async def shutdown_server():
    os.kill(os.getpid(), signal.SIGTERM)
    return {"message": "Arrêt du serveur."}

@router.get("/healthz")
async def health_check():
    """Endpoint de santé minimaliste pour Render."""
    return {"status": "ok"}

@router.get("/")
def read_root():
    return {"status": "Backend fonctionnel"}