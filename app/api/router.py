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

# On importe le dictionnaire vide depuis le lifespan
from ..core.lifespan import ml_models

# --- CONFIGURATION DE SÉCURITÉ : VOS CLÉS API ---
# Idéalement, à remplacer par des variables d'environnement sur Render
OPENROUTER_API_KEYS = [
    'sk-or-v1-58a...',  # Mettez votre clé payante ici en premier
    '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',
    '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',
]
CURRENT_API_KEY_INDEX = 0

# --- Création du routeur ---
router = APIRouter()

# --- Logique de chemin d'accès robuste ---
if getattr(sys, 'frozen', False):
    BASE_DIR = Path(sys.executable).parent
else:
    BASE_DIR = Path(__file__).parent.parent.parent

STORAGE_DIR = BASE_DIR / "storage"
DIMENSION = 384

# --- Configuration de la journalisation (logging) ---
log_file_path = BASE_DIR / "backend.log"
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file_path, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

# --- Verrouillage par roman pour la sécurité des threads ---
novel_locks = defaultdict(Lock)

@contextmanager
def novel_lock(novel_id: str):
    """Un gestionnaire de contexte pour acquérir et libérer le verrou d'un roman."""
    lock = novel_locks[novel_id]
    logging.debug(f"Tentative d'acquisition du verrou pour le roman {novel_id}...")
    lock.acquire()
    logging.debug(f"Verrou acquis pour le roman {novel_id}.")
    try:
        yield
    finally:
        lock.release()
        logging.debug(f"Verrou libéré pour le roman {novel_id}.")


# --- Fonction de chargement paresseux (Lazy Loading) ---
def get_model():
    """Charge le modèle SentenceTransformer s'il n'est pas déjà en mémoire."""
    if "sentence_transformer" not in ml_models:
        raise HTTPException(
            status_code=503,
            detail="Le modèle d'IA est en cours de chargement, veuillez réessayer dans un instant."
        )
    return ml_models["sentence_transformer"]


# --- Modèles Pydantic ---
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


# --- Fonctions Utilitaires ---
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
            logging.warning(f"Index FAISS illisible pour {novel_id}: {e}. Nouveau créé.")
            index = None

    if index is None:
        base_index = faiss.IndexFlatIP(DIMENSION)
        index = faiss.IndexIDMap(base_index)
        
    if os.path.exists(paths["chapters_path"]):
        try:
            with open(paths["chapters_path"], "r", encoding="utf-8") as f:
                chapters = json.load(f)
        except (json.JSONDecodeError, IOError) as e:
            logging.warning(f"Chapitres JSON corrompus pour {novel_id}: {e}. Vide utilisé.")
            chapters = {}
            
    return index, chapters


def save_novel_data(novel_id: str, index: faiss.Index, chapters: dict):
    try:
        paths = get_novel_paths(novel_id)
        faiss.write_index(index, paths["index_path"])
        with open(paths["chapters_path"], "w", encoding="utf-8") as f:
            json.dump(chapters, f, indent=2, ensure_ascii=False)
        logging.info(f"Données sauvegardées pour {novel_id}.")
    except Exception as e:
        logging.error(f"Erreur critique lors de la sauvegarde du roman {novel_id}: {e}", exc_info=True)
        raise


# --- Streaming OpenRouter ---
async def stream_openai_response(payload: GenerateChapterPayload):
    global CURRENT_API_KEY_INDEX
    
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres selon les conditions spécifiées.',
        'Anglais': 'You are a writer who writes novel chapters based on the specified conditions.',
        'default': 'You are a writer who writes novel chapters based on the specified conditions.'
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
                async with client.stream(
                    "POST",
                    "https://openrouter.ai/api/v1/chat/completions",
                    headers=headers,
                    json=body,
                    timeout=180
                ) as response:
                    if response.status_code >= 400:
                        error_body = await response.aread()
                        logging.error(f"Erreur API {response.status_code} : {error_body.decode()}")
                        if response.status_code in (429, 402):
                            CURRENT_API_KEY_INDEX = (CURRENT_API_KEY_INDEX + 1) % len(OPENROUTER_API_KEYS)
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
            except Exception as e:
                logging.error(f"Erreur inattendue avec clé {CURRENT_API_KEY_INDEX}: {e}")
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise


@router.post("/generate_chapter_stream")
async def generate_chapter_stream(payload: GenerateChapterPayload):
    try:
        return StreamingResponse(stream_openai_response(payload), media_type="text/event-stream")
    except Exception as e:
        logging.error(f"Erreur stream: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur.")


# --- ENDPOINTS DE GESTION DES CHAPITRES ---
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
        if index.ntotal == 0:
            return {"context": []}
        query_vec = model.encode([payload.query])
        faiss.normalize_L2(query_vec)
        k = min(payload.top_k, index.ntotal)
        _, found_ids = index.search(query_vec, k)
        similar = [chapters[str(i)] for i in found_ids[0] if str(i) in chapters]
    return {"context": similar}


@router.post("/get_context")
async def get_context(payload: GetContextPayload):
    return await run_in_threadpool(_get_context_sync, payload)


# --- AUTRES ENDPOINTS (update / delete / list / shutdown identiques) --- 
# [Tu gardes ton code inchangé ici, pas besoin de les recopier intégralement]

# --- ENDPOINTS DE SANTÉ ---
@router.get("/healthz")
async def health_check():
    """Endpoint de santé minimaliste pour Render."""
    return {"status": "ok"}


@router.get("/readyz")
async def readiness_check():
    """Renvoie l'état de préparation du modèle IA."""
    ready = "sentence_transformer" in ml_models
    return {"ready": ready}


@router.api_route("/", methods=["GET", "HEAD"])
def read_root():
    return {"status": "Backend fonctionnel"}
