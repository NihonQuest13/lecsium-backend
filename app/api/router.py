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
import httpx # <-- NOUVEL IMPORT

# On importe le dictionnaire vide depuis le lifespan
from ..core.lifespan import ml_models

# --- CONFIGURATION DE SÉCURITÉ : VOS CLÉS API ---
# NE JAMAIS LES METTRE EN DUR. Utilisez des variables d'environnement sur votre hébergeur (Render).
# Pour le test local, vous pouvez les laisser ici temporairement.
OPENROUTER_API_KEYS = [
    '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',
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
        logging.info("Le modèle d'IA n'est pas en cache. Chargement...")
        ml_models["sentence_transformer"] = SentenceTransformer("all-MiniLM-L6-v2", device='cpu')
        logging.info("Modèle d'IA chargé avec succès dans le cache.")
    return ml_models["sentence_transformer"]

# --- Définition des modèles Pydantic pour les requêtes ---
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

# --- NOUVEAU MODÈLE POUR LA GÉNÉRATION DE CHAPITRE ---
class GenerateChapterPayload(BaseModel):
    prompt: str
    model_id: str | None
    language: str


# --- Fonctions Utilitaires ---
def get_novel_paths(novel_id: str):
    """Retourne les chemins de fichiers spécifiques à un roman."""
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
    """Charge l'index FAISS et les chapitres."""
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
    """Sauvegarde les données pour un roman spécifique."""
    try:
        paths = get_novel_paths(novel_id)
        logging.info(f"Sauvegarde de l'index FAISS ({index.ntotal} vecteurs) dans {paths['index_path']}")
        faiss.write_index(index, paths["index_path"])
        logging.info(f"Sauvegarde de {len(chapters)} chapitres dans {paths['chapters_path']}")
        with open(paths["chapters_path"], "w", encoding="utf-8") as f:
            json.dump(chapters, f, indent=2, ensure_ascii=False)
        logging.info(f"Données sauvegardées avec succès pour le roman {novel_id}.")
    except Exception as e:
        logging.error(f"Erreur critique lors de la sauvegarde des données pour le roman {novel_id}: {e}", exc_info=True)
        raise

# --- NOUVEL ENDPOINT POUR LA GÉNÉRATION DE CHAPITRE ---

async def stream_openai_response(payload: GenerateChapterPayload):
    global CURRENT_API_KEY_INDEX
    
    # NOTE: Les prompts système sont maintenant nécessaires ici.
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'Anglais': 'You are a writer who writes novel chapters based on the specified conditions. Follow the instructions strictly.',
        'Espagnol': 'Eres un escritor que redacta capítulos de novelas según las condiciones especificadas. Sigue las instrucciones estrictamente.',
        'Italien': 'Sei uno scrittore che scrive capitoli di romanzi in base alle condizioni specificate. Segui rigorosamente le istruzioni.',
        'Coréen': '당신은 지정된 조건에 따라 소설의 장을 쓰는 작가입니다. 지시사항을 엄격히 따르십시오.',
        'default': 'You are a writer who writes novel chapters based on the specified conditions. Follow the instructions strictly.'
    }
    system_prompt = system_prompts.get(payload.language, system_prompts['default'])

    async with httpx.AsyncClient() as client:
        for i in range(len(OPENROUTER_API_KEYS)):
            api_key = OPENROUTER_API_KEYS[CURRENT_API_KEY_INDEX]
            headers = {
                'Authorization': f'Bearer {api_key}',
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://nihonquest.app', # Référence pour OpenRouter
                'X-Title': 'NihonQuest Novel Generator',
            }
            body = {
                'model': payload.model_id or 'deepseek/deepseek-r1-0528:free',
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': payload.prompt},
                ],
                'stream': True,
            }

            try:
                async with client.stream("POST", "https://openrouter.ai/api/v1/chat/completions", headers=headers, json=body, timeout=180) as response:
                    if response.status_code == 429 or response.status_code == 402:
                        logging.warning(f"Clé API (index {CURRENT_API_KEY_INDEX}) a atteint son quota. Essai de la suivante.")
                        CURRENT_API_KEY_INDEX = (CURRENT_API_KEY_INDEX + 1) % len(OPENROUTER_API_KEYS)
                        continue 

                    response.raise_for_status() 
                    
                    async for chunk in response.aiter_bytes():
                        yield chunk
                    return 
            
            except httpx.HTTPStatusError as e:
                logging.error(f"Erreur API avec la clé index {CURRENT_API_KEY_INDEX}: {e.response.text}")
                if i == len(OPENROUTER_API_KEYS) - 1:
                    raise 
            except Exception as e:
                 logging.error(f"Erreur inattendue avec la clé index {CURRENT_API_KEY_INDEX}: {e}")
                 if i == len(OPENROUTER_API_KEYS) - 1:
                    raise

@router.post("/generate_chapter_stream")
async def generate_chapter_stream(payload: GenerateChapterPayload):
    try:
        return StreamingResponse(stream_openai_response(payload), media_type="text/event-stream")
    except Exception as e:
        logging.error(f"Erreur critique lors de la génération du stream: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de la communication avec l'IA.")

# --- Endpoints de l'API ---

def _add_chapter_sync(payload: AddChapterPayload):
    """Fonction synchrone qui effectue le travail lourd."""
    model = get_model()
    
    with novel_lock(payload.novel_id):
        logging.info(f"THREAD: Ajout d'un chapitre au roman : {payload.novel_id}")
        index, chapters = load_novel_data(payload.novel_id)
        
        logging.info("THREAD: Encodage du texte du chapitre...")
        embedding = model.encode([payload.chapter_text])
        faiss.normalize_L2(embedding)
        logging.info("THREAD: Encodage terminé.")
        
        new_chapter_id = index.ntotal
        index.add_with_ids(embedding, np.array([new_chapter_id], dtype=np.int64))
        chapters[str(new_chapter_id)] = payload.chapter_text
        
        save_novel_data(payload.novel_id, index, chapters)
    
    return {"message": f"Chapitre ajouté au roman {payload.novel_id}.", "total_chapters_for_novel": index.ntotal}

@router.post("/add_chapter")
async def add_chapter(payload: AddChapterPayload):
    try:
        return await run_in_threadpool(_add_chapter_sync, payload)
    except Exception as e:
        logging.error(f"Erreur inattendue dans /add_chapter: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de l'ajout du chapitre.")

def _get_context_sync(payload: GetContextPayload):
    model = get_model()
    
    with novel_lock(payload.novel_id):
        logging.info(f"THREAD: Recherche de contexte pour le roman {payload.novel_id}...")
        index, chapters = load_novel_data(payload.novel_id)
        if index.ntotal == 0:
            return {"context": [], "message": "Ce roman n'a pas encore de chapitres indexés."}
        
        query_vec = model.encode([payload.query])
        faiss.normalize_L2(query_vec)
        
        k = min(payload.top_k, index.ntotal)
        distances, found_ids = index.search(query_vec, k)
        similar_chapters = [chapters[str(i)] for i in found_ids[0] if str(i) in chapters]
    
    logging.info(f"THREAD: {len(similar_chapters)} chapitres de contexte trouvés.")
    return {"context": similar_chapters}

@router.post("/get_context")
async def get_context(payload: GetContextPayload):
    try:
        return await run_in_threadpool(_get_context_sync, payload)
    except Exception as e:
        logging.error(f"Erreur inattendue dans /get_context: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de la recherche de contexte.")

def _update_chapter_sync(payload: UpdateChapterPayload):
    model = get_model()
    chapter_id_str = str(payload.chapter_id)
    
    with novel_lock(payload.novel_id):
        logging.info(f"THREAD: Mise à jour du chapitre {chapter_id_str} pour le roman {payload.novel_id}")
        
        index, chapters = load_novel_data(payload.novel_id)
        if chapter_id_str not in chapters:
            raise FileNotFoundError(f"Le chapitre avec l'ID {payload.chapter_id} n'a pas été trouvé.")
        
        chapters[chapter_id_str] = payload.new_chapter_text
        new_embedding = model.encode([payload.new_chapter_text])
        faiss.normalize_L2(new_embedding)
        
        selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
        index.remove_ids(selector)
        index.add_with_ids(new_embedding, np.array([payload.chapter_id], dtype=np.int64))
        
        save_novel_data(payload.novel_id, index, chapters)
        
    return {"message": f"Chapitre {payload.chapter_id} du roman {payload.novel_id} mis à jour avec succès."}

@router.post("/update_chapter")
async def update_chapter(payload: UpdateChapterPayload):
    try:
        return await run_in_threadpool(_update_chapter_sync, payload)
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        logging.error(f"Erreur inattendue dans /update_chapter: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de la mise à jour.")

def _delete_chapter_sync(payload: DeleteChapterPayload):
    model = get_model()
    chapter_id_to_delete = payload.chapter_id
    
    with novel_lock(payload.novel_id):
        logging.info(f"THREAD: Suppression optimisée du chapitre {chapter_id_to_delete} pour le roman {payload.novel_id}")
        
        index, chapters = load_novel_data(payload.novel_id)
        
        if str(chapter_id_to_delete) not in chapters:
            raise FileNotFoundError(f"Le chapitre {chapter_id_to_delete} est introuvable.")
            
        selector = faiss.IDSelectorBatch(np.array([chapter_id_to_delete], dtype=np.int64))
        index.remove_ids(selector)
        del chapters[str(chapter_id_to_delete)]

        if not chapters:
            delete_novel_data_sync(payload.novel_id)
            return {"message": "Dernier chapitre supprimé, toutes les données du roman ont été effacées."}

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

    return {"message": f"Chapitre {payload.chapter_id} supprimé et données ré-indexées efficacement."}

@router.post("/delete_chapter")
async def delete_chapter(payload: DeleteChapterPayload):
    try:
        return await run_in_threadpool(_delete_chapter_sync, payload)
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        logging.error(f"Erreur inattendue dans /delete_chapter: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur lors de la suppression.")

def delete_novel_data_sync(novel_id: str):
    """Fonction synchrone pour supprimer les données d'un roman."""
    try:
        paths = get_novel_paths(novel_id)
        novel_storage_path = paths["storage_path"]
        if os.path.exists(novel_storage_path) and os.path.isdir(novel_storage_path):
            shutil.rmtree(novel_storage_path)
            logging.info(f"Données pour le roman {novel_id} supprimées avec succès.")
        else:
            logging.warning(f"Aucun dossier à supprimer pour le roman {novel_id} (chemin: {novel_storage_path}).")
    except Exception as e:
        logging.error(f"Erreur lors de la suppression du dossier {novel_storage_path}: {e}")
        raise

@router.post("/delete_novel")
async def delete_novel(payload: DeleteNovelPayload):
    try:
        with novel_lock(payload.novel_id):
            delete_novel_data_sync(payload.novel_id)
        return {"message": f"Les données du roman {payload.novel_id} ont été supprimées."}
    except Exception as e:
        logging.error(f"Erreur inattendue dans /delete_novel: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne du serveur.")

@router.get("/list_novels")
async def list_indexed_novels():
    """Scanne le dossier de stockage et retourne la liste des ID de romans."""
    if not STORAGE_DIR.exists():
        return {"indexed_novels": []}
    try:
        novel_ids = [d.name for d in STORAGE_DIR.iterdir() if d.is_dir()]
        return {"indexed_novels": novel_ids}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur lors du scan du dossier de stockage : {e}")

@router.post("/shutdown")
async def shutdown_server():
    """Arrête proprement le processus du serveur."""
    logging.info("Requête d'arrêt reçue. Le serveur va s'éteindre.")
    os.kill(os.getpid(), signal.SIGTERM)
    return {"message": "Le serveur est en cours d'arrêt."}

@router.get("/")
def read_root():
    return {"status": "Backend local multi-romans fonctionnel"}