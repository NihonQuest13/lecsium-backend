# backend/app/api/router.py (MODIFIÉ ET COMPLET)
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

# Correction pour l'import relatif si nécessaire (utile pour certains environnements)
try:
    from ..core.lifespan import ml_models
except ImportError:
    # Ajustement si exécuté différemment ou si la structure change
     sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))
     from app.core.lifespan import ml_models


# ============================================================================
# CONFIGURATION
# ============================================================================

# Configuration des clés API
api_keys_str = os.environ.get('OPENROUTER_API_KEYS', '')
OPENROUTER_API_KEYS = [key.strip() for key in api_keys_str.split(',') if key.strip()]
DEEPL_API_KEY = os.environ.get('DEEPL_API_KEY', '')

if not OPENROUTER_API_KEYS:
    logging.warning("Aucune variable d'environnement OPENROUTER_API_KEYS trouvée. Utilisation des clés locales (placeholders).")
    # Mettez des placeholders ici si nécessaire, mais idéalement utilisez les variables d'env
    OPENROUTER_API_KEYS = ['YOUR_OPENROUTER_KEY_1', 'YOUR_OPENROUTER_KEY_2'] # Exemple

if not DEEPL_API_KEY:
    logging.warning("Aucune variable d'environnement DEEPL_API_KEY trouvée. La traduction échouera.")

CURRENT_API_KEY_INDEX = 0

# --- AJOUT : CONFIGURATION CENTRALISÉE DES MODÈLES ---
# Modifiez les valeurs ici pour changer les modèles utilisés dans toute l'application.
MODEL_CONFIG = {
    # Modèle par défaut pour la génération de chapitres (streaming et non-streaming)
    "default_generation": "deepseek/deepseek-r1-0528:free",
    
    # Modèle rapide pour les tâches utilitaires (ex: lecture hiragana)
    "hiragana_reading": "deepseek/deepseek-r1-0528:free",
    
    # Modèle utilisé pour la génération/mise à jour de la roadmap (résumé)
    "roadmap_summary": "deepseek/deepseek-r1-0528:free", 
}
# --- FIN AJOUT ---


# Configuration des chemins
if getattr(sys, 'frozen', False):
    # Si l'application est packagée (PyInstaller)
    BASE_DIR = Path(sys.executable).parent
else:
    # Chemin relatif au fichier actuel dans le développement normal
    BASE_DIR = Path(__file__).parent.parent.parent

STORAGE_DIR = BASE_DIR / "storage"
DIMENSION = 384 # Dimension des embeddings du modèle 'all-MiniLM-L6-v2'

# Configuration du logging
log_file_path = BASE_DIR / "backend.log"
logging.basicConfig(
    level=logging.INFO, # Assurez-vous que le niveau est au moins INFO pour voir les logs ajoutés
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file_path, encoding='utf-8'),
        logging.StreamHandler() # Affiche aussi dans la console (utile pour Render)
    ]
)

# Router FastAPI
router = APIRouter()

# Verrous pour éviter les accès concurrents aux fichiers d'un même roman
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

# --- MODÈLE AJOUTÉ POUR LA ROADMAP ---
class RoadmapPayload(BaseModel):
    novel_title: str
    language: str
    model_id: str | None = None # Modèle IA à utiliser pour générer la roadmap
    current_roadmap: str | None = None # Roadmap actuelle (si elle existe)
    chapters_content: str # Contenu des N derniers chapitres pertinents
# --- FIN AJOUT ---

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
        logging.error("Tentative d'accès au modèle SentenceTransformer avant son chargement.")
        raise HTTPException(
            status_code=503, # Service Unavailable
            detail="Le modèle d'IA (embeddings) est en cours de chargement, veuillez réessayer dans un instant."
        )
    return ml_models["sentence_transformer"]

def get_novel_paths(novel_id: str) -> dict[str, str]:
    """Retourne les chemins de stockage pour un roman donné."""
    try:
        # Assurer que le dossier de base existe
        STORAGE_DIR.mkdir(parents=True, exist_ok=True)
        novel_storage_path = STORAGE_DIR / str(novel_id)
        # Assurer que le dossier spécifique au roman existe
        novel_storage_path.mkdir(exist_ok=True)
        return {
            "storage_path": str(novel_storage_path),
            "index_path": str(novel_storage_path / "faiss_index.bin"),
            "chapters_path": str(novel_storage_path / "chapters.json"),
        }
    except Exception as e:
        logging.error(f"Impossible de créer/accéder aux chemins pour le roman {novel_id}: {e}", exc_info=True)
        raise # Renvoyer l'exception pour que l'appelant sache qu'il y a eu un problème

def load_novel_data(novel_id: str) -> tuple[faiss.Index, dict]:
    """Charge l'index FAISS et les chapitres d'un roman."""
    paths = get_novel_paths(novel_id)
    index = None
    chapters = {} # Dictionnaire pour stocker les chapitres { "id_chapitre": "contenu" }

    # Charger l'index FAISS s'il existe
    if os.path.exists(paths["index_path"]):
        try:
            index = faiss.read_index(paths["index_path"])
            logging.info(f"Index FAISS chargé pour {novel_id} (contient {index.ntotal} vecteurs)")
        except Exception as e:
            # Si l'index est corrompu, on le recréera
            logging.warning(f"Fichier index FAISS corrompu ou illisible pour {novel_id}. Il sera recréé. Erreur: {e}")
            index = None

    # Créer un nouvel index s'il n'a pas été chargé ou s'il n'existait pas
    if index is None:
        # IndexFlatIP: Recherche par produit scalaire (adapté aux vecteurs normalisés L2)
        base_index = faiss.IndexFlatIP(DIMENSION)
        # IndexIDMap: Permet d'associer un ID personnalisé (l'ID du chapitre) à chaque vecteur
        index = faiss.IndexIDMap(base_index)
        logging.info(f"Nouvel index FAISS (dimension {DIMENSION}) créé pour {novel_id}")

    # Charger les chapitres depuis le fichier JSON s'il existe
    if os.path.exists(paths["chapters_path"]):
        try:
            with open(paths["chapters_path"], "r", encoding="utf-8") as f:
                chapters = json.load(f)
            logging.info(f"{len(chapters)} chapitres chargés depuis JSON pour {novel_id}")
        except (json.JSONDecodeError, IOError) as e:
            # Si le fichier est corrompu, on commence avec un dictionnaire vide
            logging.warning(f"Fichier JSON des chapitres corrompu ou illisible pour {novel_id}. Démarrage avec une liste vide. Erreur: {e}")
            chapters = {}

    return index, chapters

def save_novel_data(novel_id: str, index: faiss.Index, chapters: dict) -> None:
    """Sauvegarde l'index FAISS et les chapitres d'un roman."""
    try:
        paths = get_novel_paths(novel_id)
        # Sauvegarder l'index FAISS
        faiss.write_index(index, paths["index_path"])
        # Sauvegarder les chapitres en JSON
        with open(paths["chapters_path"], "w", encoding="utf-8") as f:
            # indent=2 pour la lisibilité, ensure_ascii=False pour les caractères non-ASCII (japonais)
            json.dump(chapters, f, indent=2, ensure_ascii=False)
        logging.info(f"Données sauvegardées avec succès pour le roman {novel_id} ({index.ntotal} vecteurs, {len(chapters)} chapitres)")
    except Exception as e:
        logging.error(f"Erreur critique lors de la sauvegarde pour le roman {novel_id}: {e}", exc_info=True)
        # Il est important de lever l'exception pour signaler l'échec
        raise

def delete_novel_data_sync(novel_id: str) -> None:
    """Supprime toutes les données (dossier) d'un roman."""
    try:
        paths = get_novel_paths(novel_id)
        novel_folder = paths["storage_path"]
        if os.path.exists(novel_folder):
            shutil.rmtree(novel_folder)
            logging.info(f"Dossier de stockage supprimé pour le roman {novel_id} : {novel_folder}")
        else:
            logging.warning(f"Tentative de suppression du dossier pour le roman {novel_id}, mais il n'existait pas: {novel_folder}")
    except Exception as e:
        logging.error(f"Erreur lors de la suppression du dossier {novel_folder} pour le roman {novel_id}: {e}", exc_info=True)
        raise

# ============================================================================
# COMMUNICATION AVEC L'API OPENROUTER
# ============================================================================

async def make_api_request(
    prompt: str,
    model_id: str | None,
    language: str, # Utilisé pour choisir le prompt système approprié
    system_prompt_key: str = 'default' # Clé pour sélectionner le bon prompt système
) -> str:
    """Effectue une requête NON-STREAMING à l'API OpenRouter avec gestion des clés multiples."""
    global CURRENT_API_KEY_INDEX

    if not OPENROUTER_API_KEYS:
        logging.error("Aucune clé API OpenRouter n'est configurée.")
        raise HTTPException(status_code=500, detail="Configuration serveur incorrecte: Clés API manquantes.")

    # Prompts système adaptés à la tâche demandée
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'hiragana': 'あなたは日本語の単語のひらがなの読みを提供するアシスタNTです。返答にはひらがなのみを含めてください。説明は不要です。',
        'roadmap': 'You are an assistant specializing in summarizing novel plots into a single, coherent narrative paragraph.',
        'default': 'You are a helpful assistant.' # Un prompt générique par défaut
    }

    system_prompt = system_prompts.get(system_prompt_key, system_prompts.get(language, system_prompts['default']))
    
    # --- MODIFIÉ : Utilisation de MODEL_CONFIG ---
    # Utilise le modèle demandé, ou le modèle par défaut de la config s'il n'est pas spécifié
    model_to_use = model_id or MODEL_CONFIG["default_generation"]
    # --- FIN MODIFICATION ---
    
    logging.info(f"Requête API (non-streaming) vers '{model_to_use}' avec system_prompt_key '{system_prompt_key}'")

    async with httpx.AsyncClient() as client:
        # Essayer chaque clé API en boucle jusqu'à succès ou épuisement
        for i in range(len(OPENROUTER_API_KEYS)):
            current_key_index_local = CURRENT_API_KEY_INDEX # Copie locale pour éviter race condition si plusieurs requêtes
            api_key = OPENROUTER_API_KEYS[current_key_index_local]

            headers = {
                'Authorization': f'Bearer {api_key}',
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://nihonquest.app', # URL de votre site (recommandé par OpenRouter)
                'X-Title': 'NihonQuest Backend' # Nom de votre application (recommandé par OpenRouter)
            }

            body = {
                'model': model_to_use,
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': prompt}
                ],
                'stream': False # Important: cette fonction est pour les requêtes non-streamées
            }

            try:
                response = await client.post(
                    "https://openrouter.ai/api/v1/chat/completions",
                    headers=headers,
                    json=body,
                    timeout=120 # Timeout de 2 minutes pour les requêtes non-streamées
                )

                # Gestion des erreurs HTTP
                if response.status_code >= 400:
                    error_content = response.text
                    logging.error(f"Erreur API ({response.status_code}) avec clé {current_key_index_local}: {error_content}")

                    # Si c'est une erreur de crédit (402) ou de rate limit (429), passer à la clé suivante
                    if response.status_code in [429, 402]:
                        # Incrémenter l'index global de manière atomique (en cas de concurrence)
                        # Cette approche simple n'est pas parfaitement atomique mais suffisante ici.
                        CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                        logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à l'erreur {response.status_code}.")
                        continue # Essayer la clé suivante
                    else:
                        # Pour les autres erreurs (400, 401, 500...), lever une exception HTTP
                        response.raise_for_status() # Lève une httpx.HTTPStatusError

                # Si la requête réussit (status code < 400)
                data = response.json()
                content = data.get('choices', [{}])[0].get('message', {}).get('content', '')
                logging.info(f"Réponse API reçue avec succès (Clé {current_key_index_local}). Longueur: {len(content)}")
                return content.strip() # Retourner le contenu de la réponse

            except httpx.HTTPStatusError as e:
                # Si l'erreur n'est pas 429 ou 402, on lève l'exception
                 logging.error(f"HTTPStatusError non gérable (Clé {current_key_index_local}): {e}")
                 # Si c'est la dernière clé, on abandonne
                 if i == len(OPENROUTER_API_KEYS) - 1:
                     logging.error("Toutes les clés ont échoué (HTTPStatusError).")
                     raise HTTPException(status_code=503, detail=f"Erreur API OpenRouter: {e.response.text}")
                 else: # Sinon, on tente quand même la suivante au cas où ? Non, on arrête si l'erreur n'est pas gérable.
                    raise HTTPException(status_code=e.response.status_code, detail=f"Erreur API OpenRouter: {e.response.text}")

            except httpx.TimeoutException as e:
                logging.error(f"Timeout lors de la requête API (Clé {current_key_index_local}): {e}")
                # Si c'est la dernière clé, on abandonne
                if i == len(OPENROUTER_API_KEYS) - 1:
                     logging.error("Toutes les clés ont échoué (Timeout).")
                     raise HTTPException(status_code=504, detail="Timeout lors de la communication avec l'API OpenRouter.")
                 # On peut aussi essayer la clé suivante en cas de timeout ? Oui.
                CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à un Timeout.")
                continue

            except Exception as e:
                logging.error(f"Erreur inattendue lors de la requête API (Clé {current_key_index_local}): {e}", exc_info=True)
                 # Si c'est la dernière clé, on abandonne
                if i == len(OPENROUTER_API_KEYS) - 1:
                    logging.error("Toutes les clés ont échoué (Exception inattendue).")
                    raise HTTPException(status_code=500, detail=f"Erreur interne inattendue lors de la communication avec l'API: {e}")
                # Essayer la clé suivante en cas d'erreur inconnue ? Oui.
                CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à une erreur inattendue.")
                continue

        # Si la boucle se termine sans succès
        logging.error("Toutes les clés API OpenRouter ont échoué après la boucle.")
        raise HTTPException(status_code=503, detail="Toutes les clés API configurées ont échoué (crédits épuisés ou rate limit).")

async def stream_openai_response(payload: GenerateChapterPayload):
    """Stream la réponse de l'API OpenRouter pour la génération de chapitres."""
    global CURRENT_API_KEY_INDEX

    if not OPENROUTER_API_KEYS:
        logging.error("Aucune clé API OpenRouter n'est configurée.")
        raise HTTPException(status_code=500, detail="Configuration serveur incorrecte: Clés API manquantes.")

    # Logging initial de la demande de stream
    logging.info("===== NOUVELLE DEMANDE DE STREAM =====")
    logging.info(f"Modèle demandé: {payload.model_id or 'default'}")
    logging.info(f"Taille du prompt: {len(payload.prompt)} caractères")
    # Log tronqué pour éviter de spammer les logs si en mode DEBUG (mettre level=DEBUG pour voir)
    logging.debug(f"Prompt (tronqué): {payload.prompt[:500]}...")

    # Choix du prompt système
    system_prompts = {
        'Japonais': 'あなたは指定された条件に基づいて日本語の小説の章を書く作家です。指示に厳密に従ってください。',
        'Français': 'Vous êtes un écrivain qui rédige des chapitres de romans en fonction des conditions spécifiées. Suivez strictement les instructions.',
        'default': 'You are a writer who writes novel chapters based on provided context and instructions. Follow the instructions strictly.'
    }
    system_prompt = system_prompts.get(payload.language, system_prompts['default'])
    
    # --- MODIFIÉ : Utilisation de MODEL_CONFIG ---
    # Choix du modèle à utiliser
    model_to_use = payload.model_id or MODEL_CONFIG["default_generation"]
    # --- FIN MODIFICATION ---
    
    logging.info(f"Utilisation du modèle: {model_to_use}") # Log du modèle réellement utilisé

    async with httpx.AsyncClient() as client:
        # Essayer chaque clé API en boucle
        for i in range(len(OPENROUTER_API_KEYS)):
            current_key_index_local = CURRENT_API_KEY_INDEX
            api_key = OPENROUTER_API_KEYS[current_key_index_local]
            logging.info(f"Tentative de stream avec la clé API index {current_key_index_local}")

            headers = {
                'Authorization': f'Bearer {api_key}',
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://nihonquest.app',
                'X-Title': 'NihonQuest Novel Generator' # Titre spécifique pour cette fonction
            }

            body = {
                'model': model_to_use,
                'messages': [
                    {'role': 'system', 'content': system_prompt},
                    {'role': 'user', 'content': payload.prompt}
                ],
                'stream': True # Activer le mode streaming
            }

            try:
                # Utiliser client.stream pour une requête en streaming
                async with client.stream(
                    "POST",
                    "https://openrouter.ai/api/v1/chat/completions",
                    headers=headers,
                    json=body,
                    timeout=180 # Timeout plus long pour le streaming (3 minutes)
                ) as response:
                    # Gestion des erreurs HTTP AVANT de commencer à lire le stream
                    if response.status_code >= 400:
                        error_body = await response.aread() # Lire le corps de l'erreur
                        error_content = error_body.decode()
                        logging.error(f"ERREUR STREAM API (Clé {current_key_index_local}, Status {response.status_code}): {error_content}")

                        # Si erreur de crédit ou rate limit, essayer la clé suivante
                        if response.status_code in [429, 402]:
                            CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                            logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à l'erreur {response.status_code}.")
                            continue # Essayer la clé suivante
                        else:
                            # Erreur non récupérable (ex: 400 Bad Request - prompt trop long, 401 Auth, 500 Serveur IA)
                            logging.error(f"Erreur non récupérable (Status {response.status_code}), arrêt du cycle des clés.")
                            # Lever une exception pour que l'endpoint principal la gère
                            raise httpx.HTTPStatusError(
                                f"Erreur {response.status_code}: {error_content}",
                                request=response.request,
                                response=response
                            )

                    # Si la connexion initiale est OK (status < 400)
                    logging.info(f"Stream connecté avec succès (Clé {current_key_index_local}). Début du streaming...")
                    # Lire le stream chunk par chunk
                    async for chunk in response.aiter_bytes():
                        # Renvoyer chaque chunk tel quel au client FastAPI
                        yield chunk
                    logging.info("Stream terminé avec succès (connexion fermée par le serveur).")
                    return # Important : sortir de la fonction et de la boucle après un succès

            except httpx.HTTPStatusError as e:
                # Attrape l'erreur levée ci-dessus si status >= 400 et non gérable
                logging.error(f"HTTPStatusError (Clé {current_key_index_local}) dans stream_openai_response: {e}")
                # Si c'est la dernière clé, l'exception sera levée à l'extérieur
                if i == len(OPENROUTER_API_KEYS) - 1:
                    logging.error("Toutes les clés ont échoué (HTTPStatusError final).")
                    raise # Renvoyer l'exception pour l'endpoint principal

            except httpx.TimeoutException as e:
                logging.error(f"Timeout pendant le stream (Clé {current_key_index_local}): {e}")
                if i == len(OPENROUTER_API_KEYS) - 1:
                     logging.error("Toutes les clés ont échoué (Timeout final).")
                     raise HTTPException(status_code=504, detail="Timeout pendant le streaming de la réponse de l'API.")
                # Essayer la clé suivante en cas de timeout
                CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à un Timeout pendant le stream.")
                continue

            except Exception as e:
                logging.error(f"Erreur inattendue pendant le stream (Clé {current_key_index_local}): {e}", exc_info=True)
                if i == len(OPENROUTER_API_KEYS) - 1:
                    logging.error("Toutes les clés ont échoué (Exception inattendue finale).")
                    raise # Renvoyer l'exception pour l'endpoint principal
                # Essayer la clé suivante
                CURRENT_API_KEY_INDEX = (current_key_index_local + 1) % len(OPENROUTER_API_KEYS)
                logging.info(f"Basculement vers la clé API {CURRENT_API_KEY_INDEX} suite à une erreur inattendue pendant le stream.")
                continue

        # Si la boucle se termine sans 'return', c'est que toutes les clés ont échoué
        logging.error("Toutes les clés API ont échoué pour le stream (fin de boucle).")
        raise HTTPException(status_code=503, detail="Toutes les clés API ont échoué (crédits épuisés ou rate limit persistant).")

# ============================================================================
# ENDPOINTS - TRADUCTION
# ============================================================================

@router.post("/get_translation")
async def get_translation(payload: TranslationPayload):
    """Obtient la lecture hiragana et la traduction française d'un mot japonais."""
    word = payload.word.strip()

    if not word:
        raise HTTPException(status_code=400, detail="Le mot ne peut pas être vide.")

    logging.info(f"Demande de traduction/lecture pour le mot: '{word}'")
    reading, translation = None, None
    reading_error, translation_error = None, None

    # 1. Obtenir la lecture en hiragana via LLM (make_api_request gère les clés)
    try:
        hiragana_prompt = (
            f"Donne la lecture en hiragana uniquement pour le mot japonais suivant : ```{word}```. "
            "Ne fournis PAS d'explications, seulement les hiraganas. Si le mot contient déjà des hiraganas ou katakanas, renvoie le mot tel quel."
            "Si le mot est entièrement en alphabet latin, renvoie une chaîne vide."
        )
        
        # --- MODIFIÉ : Utilisation de MODEL_CONFIG ---
        reading_result = await make_api_request(
            prompt=hiragana_prompt,
            model_id=MODEL_CONFIG["hiragana_reading"], # Utilise le modèle défini pour les hiragana
            language='Japonais', # Pour le prompt système
            system_prompt_key='hiragana' # Prompt système spécifique
        )
        # --- FIN MODIFICATION ---
        
        # Nettoyage simple de la réponse
        reading = reading_result.strip().replace('`', '').replace('*', '').replace("'", "").replace('"', '')

        if not reading:
             # Si l'IA renvoie une chaîne vide (ex: mot en alphabet latin), ce n'est pas une erreur
             logging.info(f"Lecture hiragana non applicable ou non trouvée pour '{word}'.")
             reading_error = "Lecture non trouvée ou non applicable." # Message plus informatif
        else:
             logging.info(f"Lecture hiragana obtenue pour '{word}': {reading}")

    except HTTPException as e:
        # Si make_api_request lève une HTTPException (échec de toutes les clés, etc.)
        logging.error(f"Erreur HTTP lors de l'obtention de la lecture pour '{word}': {e.detail}")
        reading_error = f"Erreur IA ({e.status_code})"
    except Exception as e:
        logging.error(f"Erreur inattendue lors de l'obtention de la lecture pour '{word}': {e}", exc_info=True)
        reading_error = "Erreur IA inattendue."

    # 2. Obtenir la traduction via DeepL si la clé est configurée
    if DEEPL_API_KEY:
        try:
            # Utiliser httpx pour l'appel asynchrone à DeepL
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    "https://api-free.deepl.com/v2/translate" if ':fx' not in DEEPL_API_KEY else "https://api.deepl.com/v2/translate",
                    headers={'Authorization': f'DeepL-Auth-Key {DEEPL_API_KEY}'},
                    data={
                        'text': word,
                        'source_lang': 'JA',
                        'target_lang': 'FR'
                    },
                    timeout=15 # Timeout de 15 secondes pour DeepL
                )
                response.raise_for_status() # Lève une exception pour les status >= 400

                result = response.json()
                translation = result['translations'][0]['text'].strip()

                if not translation:
                    logging.warning(f"Traduction DeepL vide reçue pour '{word}'.")
                    translation_error = "Traduction vide."
                    translation = None # Assurer que c'est None si vide
                else:
                    logging.info(f"Traduction DeepL obtenue pour '{word}': {translation}")

        except httpx.HTTPStatusError as e:
            logging.error(f"Erreur HTTP DeepL pour '{word}': Status {e.response.status_code}, Réponse: {e.response.text}")
            translation_error = f"Erreur DeepL ({e.response.status_code})"
        except httpx.TimeoutException:
            logging.error(f"Timeout lors de l'appel à DeepL pour '{word}'.")
            translation_error = "Timeout DeepL."
        except Exception as e:
            logging.error(f"Erreur inattendue lors de l'appel à DeepL pour '{word}': {e}", exc_info=True)
            translation_error = "Erreur DeepL inattendue."
    else:
        # Si la clé DeepL n'est pas configurée
        logging.warning("Clé API DeepL non configurée, impossible de traduire.")
        translation_error = "Clé API DeepL manquante."

    # Renvoyer le résultat combiné
    return {
        "reading": reading,
        "translation": translation,
        "readingError": reading_error,
        "translationError": translation_error
    }

# ============================================================================
# ENDPOINTS - GÉNÉRATION (Chapitre + Roadmap)
# ============================================================================

@router.post("/generate_chapter_stream")
async def generate_chapter_stream(payload: GenerateChapterPayload):
    """Génère un chapitre en streaming en appelant stream_openai_response."""
    try:
        # Appelle la fonction qui gère le streaming et la rotation des clés
        return StreamingResponse(
            stream_openai_response(payload),
            media_type="text/event-stream" # Type MIME pour Server-Sent Events (SSE)
        )
    except HTTPException as e:
        # Si stream_openai_response lève une HTTPException (ex: toutes clés échouées), la renvoyer
        logging.error(f"HTTPException interceptée dans generate_chapter_stream: Status {e.status_code}, Détail: {e.detail}")
        # Renvoyer l'erreur au client avec le bon status code et détail
        raise HTTPException(status_code=e.status_code, detail=e.detail)
    except Exception as e:
        # Gérer toute autre exception inattendue
        logging.error(f"Erreur critique non gérée lors du stream: {e}", exc_info=True)
        # Renvoyer une erreur 500 générique
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la communication avec l'IA: {str(e)}")

# --- ENDPOINT ROADMAP (MIGRÉ ICI) ---
@router.post("/update_roadmap")
async def update_roadmap(payload: RoadmapPayload):
    """Met à jour la feuille de route (résumé) d'un roman en appelant make_api_request."""
    logging.info(f"Demande de mise à jour de roadmap pour le roman '{payload.novel_title}'")

    # Construction du prompt basé sur l'existence d'une roadmap actuelle
    if not payload.current_roadmap:
        # Création initiale
        logging.info("Création initiale de la roadmap.")
        prompt = f'''Voici le contenu des **trois premiers chapitres** du roman "{payload.novel_title}". Analyse-les attentivement.

<Trois premiers chapitres>
{payload.chapters_content}
</Trois premiers chapitres>

Ta tâche est de créer la **première fiche de route globale** pour ce roman. Le résumé doit être rédigé dans un **style narratif naturel et fluide**, comme si tu racontais l'histoire jusqu'à présent. Inclus les éléments essentiels : les noms des personnages principaux introduits, la chronologie approximative des événements, les lieux importants et les points clés de l'intrigue qui ont été établis. Le résultat doit être un **unique paragraphe cohérent et engageant**. Ne commence PAS par un titre ou une introduction du type "Voici le résumé".'''
    else:
        # Mise à jour
        logging.info("Mise à jour de la roadmap existante.")
        prompt = f'''Voici le résumé global (fiche de route) actuel du roman "{payload.novel_title}".

<Fiche de route actuelle>
{payload.current_roadmap}
</Fiche de route actuelle>

Et voici le contenu textuel intégral des **trois derniers chapitres** publiés. Analyse-les attentivement pour comprendre la progression de l'histoire.

<3 derniers chapitres>
{payload.chapters_content}
</3 derniers chapitres>

Ta tâche est de **mettre à jour** la fiche de route en intégrant les événements et informations des trois derniers chapitres. Le nouveau résumé doit remplacer l'ancien. Rédige-le dans un **style narratif naturel et fluide**, en continuant l'histoire. Assure-toi d'inclure les nouveaux personnages, les développements de l'intrigue, les changements de lieux et toute évolution significative. Le résultat doit être un **unique paragraphe, nouveau, complet et cohérent**, résumant toute l'histoire depuis le début jusqu'à la fin du dernier chapitre fourni. Ne commence PAS par un titre ou une introduction du type "Voici la mise à jour".'''

    try:
        # --- MODIFIÉ : Utilisation de MODEL_CONFIG ---
        # Choisir le modèle : celui spécifié dans le payload, ou celui de la config par défaut
        model_for_roadmap = payload.model_id or MODEL_CONFIG["roadmap_summary"]
        # --- FIN MODIFICATION ---
        
        logging.info(f"Utilisation du modèle '{model_for_roadmap}' pour la génération de la roadmap.")

        # Appel à la fonction qui gère l'appel API non-streamé et la rotation des clés
        new_roadmap = await make_api_request(
            prompt=prompt,
            model_id=model_for_roadmap,
            language=payload.language, # Pour le prompt système
            system_prompt_key='roadmap' # Prompt système spécifique au résumé
        )

        if not new_roadmap:
             logging.warning(f"La génération de la roadmap pour '{payload.novel_title}' a retourné une chaîne vide.")
             # Renvoyer une erreur 500 car le résultat attendu n'est pas là
             raise HTTPException(status_code=500, detail="La génération de la roadmap a retourné un résultat vide.")

        logging.info(f"Nouvelle roadmap générée avec succès pour '{payload.novel_title}' (longueur: {len(new_roadmap)}).")
        return {"roadmap": new_roadmap}

    except HTTPException as e:
         # Si make_api_request lève une HTTPException, la renvoyer
         logging.error(f"Erreur HTTP lors de la mise à jour de la roadmap pour '{payload.novel_title}': {e.detail}")
         raise HTTPException(status_code=e.status_code, detail=e.detail)
    except Exception as e:
        # Gérer toute autre exception inattendue
        logging.error(f"Erreur inattendue lors de la mise à jour de la roadmap pour '{payload.novel_title}': {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la génération de la roadmap: {str(e)}")
# --- FIN ENDPOINT ROADMAP ---


# ============================================================================
# ENDPOINTS - GESTION DES CHAPITRES (FAISS + JSON)
# ============================================================================

def _add_chapter_sync(payload: AddChapterPayload) -> dict:
    """Ajoute un chapitre (encodage, ajout FAISS, sauvegarde JSON)."""
    logging.info(f"Ajout du chapitre pour le roman {payload.novel_id}...")
    try:
        model = get_model() # Récupère le modèle d'embedding chargé au démarrage
    except HTTPException as e:
        # Si le modèle n'est pas prêt, renvoyer l'erreur 503
        logging.error("Échec de l'ajout de chapitre car le modèle d'embedding n'est pas chargé.")
        raise e

    # Verrouiller l'accès aux fichiers de ce roman spécifique
    with novel_lock(payload.novel_id):
        try:
            index, chapters = load_novel_data(payload.novel_id)

            # --- Encodage du texte du nouveau chapitre ---
            # model.encode attend une liste de textes, même s'il n'y en a qu'un
            logging.info(f"Encodage du chapitre (longueur: {len(payload.chapter_text)} caractères)...")
            embedding = model.encode([payload.chapter_text])
            # Normalisation L2 (importante si on utilise IndexFlatIP)
            faiss.normalize_L2(embedding)
            logging.info("Encodage terminé.")

            # --- Ajout à l'index FAISS ---
            # L'ID du nouveau chapitre sera simplement le nombre total de vecteurs actuels (commence à 0)
            new_chapter_id = index.ntotal
            # add_with_ids attend un tableau numpy d'IDs
            index.add_with_ids(embedding, np.array([new_chapter_id], dtype=np.int64))

            # --- Ajout au dictionnaire des chapitres ---
            # Utiliser l'ID comme clé (converti en string pour JSON)
            chapters[str(new_chapter_id)] = payload.chapter_text
            logging.info(f"Chapitre ajouté localement avec l'ID {new_chapter_id}.")

            # --- Sauvegarde des données (index FAISS et chapitres JSON) ---
            save_novel_data(payload.novel_id, index, chapters)

        except Exception as e:
            # En cas d'erreur pendant l'opération (encodage, FAISS, sauvegarde), lever une exception
            logging.error(f"Erreur lors de l'ajout synchrone du chapitre pour {payload.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de l'ajout du chapitre: {str(e)}")

    return {"message": f"Chapitre {new_chapter_id} ajouté avec succès au roman {payload.novel_id}."}

@router.post("/add_chapter")
async def add_chapter(payload: AddChapterPayload):
    """Endpoint API pour ajouter un nouveau chapitre à un roman."""
    try:
        # Exécute la fonction synchrone dans un threadpool pour ne pas bloquer la boucle d'événements
        result = await run_in_threadpool(_add_chapter_sync, payload)
        return result
    except HTTPException as e:
        # Si _add_chapter_sync lève une HTTPException, la propager
        raise e
    except Exception as e:
        # Gérer les erreurs inattendues non capturées
        logging.error(f"Erreur inattendue dans l'endpoint /add_chapter pour {payload.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne inattendue: {str(e)}")


def _update_chapter_sync(payload: UpdateChapterPayload) -> dict:
    """Met à jour un chapitre existant (texte JSON, ré-encodage, mise à jour FAISS)."""
    logging.info(f"Mise à jour du chapitre {payload.chapter_id} pour le roman {payload.novel_id}...")
    try:
        model = get_model()
    except HTTPException as e:
        logging.error("Échec de la mise à jour car le modèle d'embedding n'est pas chargé.")
        raise e

    chapter_id_str = str(payload.chapter_id) # ID utilisé comme clé dans le dict JSON

    with novel_lock(payload.novel_id):
        try:
            index, chapters = load_novel_data(payload.novel_id)

            # Vérifier si le chapitre existe
            if chapter_id_str not in chapters:
                logging.error(f"Tentative de mise à jour d'un chapitre inexistant ({payload.chapter_id}) pour le roman {payload.novel_id}.")
                raise FileNotFoundError(f"Le chapitre avec l'ID {payload.chapter_id} n'a pas été trouvé pour ce roman.")

            # --- Mettre à jour le texte dans le dictionnaire ---
            chapters[chapter_id_str] = payload.new_chapter_text
            logging.info(f"Texte du chapitre {payload.chapter_id} mis à jour localement.")

            # --- Réencoder le nouveau texte ---
            logging.info(f"Ré-encodage du chapitre {payload.chapter_id} (longueur: {len(payload.new_chapter_text)} caractères)...")
            new_embedding = model.encode([payload.new_chapter_text])
            faiss.normalize_L2(new_embedding)
            logging.info("Ré-encodage terminé.")

            # --- Mettre à jour dans FAISS ---
            # 1. Supprimer l'ancien vecteur associé à cet ID
            # remove_ids attend un sélecteur d'IDs (ici un IDSelectorBatch pour un seul ID)
            selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
            removed_count = index.remove_ids(selector)
            if removed_count == 0:
                # Cela ne devrait pas arriver si l'ID était dans `chapters`, mais sécurité
                logging.warning(f"L'ID {payload.chapter_id} était dans chapters.json mais pas dans l'index FAISS pour {payload.novel_id}.")
                # On continue quand même pour ajouter le nouveau vecteur
            else:
                 logging.info(f"Ancien vecteur pour le chapitre {payload.chapter_id} supprimé de l'index FAISS.")

            # 2. Ajouter le nouveau vecteur avec le même ID
            index.add_with_ids(new_embedding, np.array([payload.chapter_id], dtype=np.int64))
            logging.info(f"Nouveau vecteur pour le chapitre {payload.chapter_id} ajouté à l'index FAISS.")

            # --- Sauvegarder les données mises à jour ---
            save_novel_data(payload.novel_id, index, chapters)

        except FileNotFoundError as e:
            # Renvoyer l'erreur spécifique si le chapitre n'est pas trouvé
            raise e
        except Exception as e:
            logging.error(f"Erreur lors de la mise à jour synchrone du chapitre {payload.chapter_id} pour {payload.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de la mise à jour du chapitre: {str(e)}")

    return {"message": f"Chapitre {payload.chapter_id} mis à jour avec succès pour le roman {payload.novel_id}."}

@router.post("/update_chapter")
async def update_chapter(payload: UpdateChapterPayload):
    """Endpoint API pour mettre à jour un chapitre existant."""
    try:
        result = await run_in_threadpool(_update_chapter_sync, payload)
        return result
    except FileNotFoundError as e:
         # Capturer l'erreur spécifique et renvoyer 404
        logging.warning(f"Échec de la mise à jour: {e}")
        raise HTTPException(status_code=404, detail=str(e))
    except HTTPException as e:
        raise e
    except Exception as e:
        logging.error(f"Erreur inattendue dans /update_chapter pour {payload.novel_id}, chapitre {payload.chapter_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne inattendue: {str(e)}")


def _delete_chapter_sync(payload: DeleteChapterPayload) -> dict:
    """Supprime un chapitre (FAISS, JSON) et réindexe si nécessaire."""
    logging.info(f"Suppression du chapitre {payload.chapter_id} pour le roman {payload.novel_id}...")
    try:
        model = get_model()
    except HTTPException as e:
        logging.error("Échec de la suppression car le modèle d'embedding n'est pas chargé.")
        raise e

    chapter_id_to_delete_str = str(payload.chapter_id)

    with novel_lock(payload.novel_id):
        try:
            index, chapters = load_novel_data(payload.novel_id)

            # Vérifier si le chapitre existe
            if chapter_id_to_delete_str not in chapters:
                logging.error(f"Tentative de suppression d'un chapitre inexistant ({payload.chapter_id}) pour le roman {payload.novel_id}.")
                raise FileNotFoundError(f"Le chapitre avec l'ID {payload.chapter_id} n'a pas été trouvé pour ce roman.")

            # --- Supprimer du FAISS index ---
            selector = faiss.IDSelectorBatch(np.array([payload.chapter_id], dtype=np.int64))
            removed_count = index.remove_ids(selector)
            if removed_count > 0:
                logging.info(f"Vecteur pour le chapitre {payload.chapter_id} supprimé de l'index FAISS.")
            else:
                 logging.warning(f"L'ID {payload.chapter_id} était dans chapters.json mais pas dans l'index FAISS lors de la suppression pour {payload.novel_id}.")

            # --- Supprimer du dictionnaire des chapitres ---
            del chapters[chapter_id_to_delete_str]
            logging.info(f"Chapitre {payload.chapter_id} supprimé du dictionnaire local.")

            # --- Vérifier si le roman est maintenant vide ---
            if not chapters:
                logging.info(f"Le roman {payload.novel_id} est maintenant vide après suppression du chapitre {payload.chapter_id}. Suppression complète du roman.")
                # Si c'était le dernier chapitre, supprimer tout le dossier du roman
                delete_novel_data_sync(payload.novel_id)
                # Pas besoin de sauvegarder car le dossier est supprimé
                return {"message": f"Chapitre {payload.chapter_id} supprimé. C'était le dernier, le roman {payload.novel_id} a été supprimé."}

            # --- Réindexation si ce n'était pas le dernier chapitre ---
            # Pour maintenir des IDs FAISS consécutifs commençant à 0, ce qui est plus simple à gérer
            logging.info(f"Réindexation nécessaire pour le roman {payload.novel_id} après suppression.")

            # 1. Trier les IDs restants et récupérer les textes correspondants dans l'ordre
            sorted_remaining_ids = sorted(chapters.keys(), key=int)
            remaining_texts = [chapters[old_id] for old_id in sorted_remaining_ids]

            # 2. Réencoder tous les textes restants
            logging.info(f"Ré-encodage de {len(remaining_texts)} chapitres restants...")
            embeddings = model.encode(remaining_texts)
            faiss.normalize_L2(embeddings)
            logging.info("Ré-encodage terminé.")

            # 3. Créer un nouvel index FAISS vide
            new_index = faiss.IndexIDMap(faiss.IndexFlatIP(DIMENSION))
            # 4. Générer les nouveaux IDs (de 0 à N-1)
            new_ids = np.arange(len(remaining_texts), dtype=np.int64)
            # 5. Ajouter les embeddings avec les nouveaux IDs
            new_index.add_with_ids(embeddings, new_ids)

            # 6. Créer le nouveau dictionnaire de chapitres avec les nouveaux IDs
            new_chapters_dict = {str(i): text for i, text in enumerate(remaining_texts)}
            logging.info(f"Nouvel index FAISS et dictionnaire de chapitres créés avec {len(new_chapters_dict)} éléments.")

            # 7. Sauvegarder le nouvel index et le nouveau dictionnaire
            save_novel_data(payload.novel_id, new_index, new_chapters_dict)

        except FileNotFoundError as e:
            raise e
        except Exception as e:
            logging.error(f"Erreur lors de la suppression/réindexation synchrone du chapitre {payload.chapter_id} pour {payload.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de la suppression/réindexation du chapitre: {str(e)}")

    return {"message": f"Chapitre {payload.chapter_id} supprimé et roman {payload.novel_id} réindexé avec succès."}

@router.post("/delete_chapter")
async def delete_chapter(payload: DeleteChapterPayload):
    """Endpoint API pour supprimer un chapitre."""
    try:
        result = await run_in_threadpool(_delete_chapter_sync, payload)
        return result
    except FileNotFoundError as e:
        logging.warning(f"Échec de la suppression: {e}")
        raise HTTPException(status_code=404, detail=str(e))
    except HTTPException as e:
        raise e
    except Exception as e:
        logging.error(f"Erreur inattendue dans /delete_chapter pour {payload.novel_id}, chapitre {payload.chapter_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne inattendue: {str(e)}")

# ============================================================================
# ENDPOINTS - RECHERCHE SÉMANTIQUE (FAISS)
# ============================================================================

def _get_context_sync(payload: GetContextPayload) -> dict:
    """Recherche sémantique des chapitres similaires (version synchrone)."""
    logging.info(f"Recherche de contexte pour le roman {payload.novel_id} avec la requête: '{payload.query[:50]}...' (top_k={payload.top_k})")
    try:
        model = get_model()
    except HTTPException as e:
        logging.error("Échec de la recherche car le modèle d'embedding n'est pas chargé.")
        raise e

    # Pas besoin de verrou exclusif pour la lecture (lecture seule)
    # Note: FAISS est généralement thread-safe pour la recherche mais pas pour les modifications.
    # Si des écritures pouvaient arriver en même temps, un verrou partagé/exclusif serait mieux.
    # Ici, le verrouillage se fait au niveau des opérations d'écriture (add, update, delete).
    try:
        index, chapters = load_novel_data(payload.novel_id)

        # Si l'index est vide ou si aucun chapitre n'est chargé
        if index.ntotal == 0 or not chapters:
            logging.warning(f"Recherche de contexte pour {payload.novel_id} : index FAISS vide ou aucun chapitre chargé.")
            return {"context": []} # Retourner une liste vide

        # --- Encodage de la requête de recherche ---
        logging.info(f"Encodage de la requête de recherche...")
        query_vec = model.encode([payload.query])
        faiss.normalize_L2(query_vec)
        logging.info("Encodage de la requête terminé.")

        # --- Recherche dans l'index FAISS ---
        # Déterminer le nombre réel de voisins à chercher (k ne peut pas dépasser ntotal)
        k = min(payload.top_k, index.ntotal)
        logging.info(f"Recherche des {k} plus proches voisins dans l'index FAISS...")
        # index.search retourne les distances (scores) et les IDs des voisins
        distances, found_ids = index.search(query_vec, k)
        logging.info(f"Recherche FAISS terminée. IDs trouvés: {found_ids[0]}, Distances: {distances[0]}")

        # --- Récupération des textes des chapitres correspondants ---
        similar_chapters_content = []
        for i, chapter_id in enumerate(found_ids[0]):
             chapter_id_str = str(chapter_id)
             if chapter_id_str in chapters:
                 # Ajouter le contenu du chapitre trouvé à la liste
                 similar_chapters_content.append(chapters[chapter_id_str])
                 logging.debug(f"  - Contexte trouvé: Chapitre ID {chapter_id_str} (Score: {distances[0][i]:.4f})")
             else:
                 # Sécurité: si un ID retourné par FAISS n'est pas dans chapters.json (devrait pas arriver si synchro)
                 logging.warning(f"ID {chapter_id_str} trouvé par FAISS mais non présent dans chapters.json pour {payload.novel_id}.")

        logging.info(f"{len(similar_chapters_content)} chapitres de contexte récupérés pour {payload.novel_id}.")

    except Exception as e:
        logging.error(f"Erreur lors de la recherche synchrone de contexte pour {payload.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne lors de la recherche de contexte: {str(e)}")

    return {"context": similar_chapters_content}

@router.post("/get_context")
async def get_context(payload: GetContextPayload):
    """Endpoint API pour rechercher les chapitres les plus pertinents pour une requête."""
    try:
        result = await run_in_threadpool(_get_context_sync, payload)
        return result
    except HTTPException as e:
        raise e
    except Exception as e:
        logging.error(f"Erreur inattendue dans /get_context pour {payload.novel_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Erreur interne inattendue: {str(e)}")

# ============================================================================
# ENDPOINTS - GESTION DES ROMANS (Suppression, Liste)
# ============================================================================

@router.post("/delete_novel")
async def delete_novel(payload: DeleteNovelPayload):
    """Supprime complètement un roman et toutes ses données associées."""
    logging.info(f"Demande de suppression complète pour le roman {payload.novel_id}.")
    # Utiliser un verrou pour s'assurer qu'aucune autre opération n'est en cours sur ce roman
    with novel_lock(payload.novel_id):
        try:
            # Appeler la fonction synchrone de suppression du dossier
            await run_in_threadpool(delete_novel_data_sync, payload.novel_id)
            # Optionnel: Supprimer le verrou de la mémoire s'il n'est plus nécessaire
            if payload.novel_id in novel_locks:
                del novel_locks[payload.novel_id]
        except Exception as e:
            # Gérer les erreurs potentielles lors de la suppression
            logging.error(f"Erreur lors de la suppression du roman {payload.novel_id}: {e}", exc_info=True)
            raise HTTPException(status_code=500, detail=f"Erreur interne lors de la suppression du roman: {str(e)}")

    return {"message": f"Roman {payload.novel_id} supprimé avec succès."}

@router.get("/list_novels")
async def list_indexed_novels():
    """Liste les IDs de tous les romans actuellement stockés."""
    logging.info("Demande de la liste des romans indexés.")
    indexed_novels = []
    # Vérifier si le dossier de stockage principal existe
    if not STORAGE_DIR.exists():
        logging.warning(f"Le dossier de stockage principal ({STORAGE_DIR}) n'existe pas.")
        return {"indexed_novels": []}

    try:
        # Lister les sous-dossiers dans le dossier de stockage
        # Chaque sous-dossier correspond à l'ID d'un roman
        indexed_novels = [
            entry.name for entry in STORAGE_DIR.iterdir() if entry.is_dir()
        ]
        logging.info(f"{len(indexed_novels)} romans trouvés dans {STORAGE_DIR}.")
    except Exception as e:
        logging.error(f"Erreur lors du listage des dossiers dans {STORAGE_DIR}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail="Erreur interne lors du listage des romans.")

    return {"indexed_novels": indexed_novels}

# ============================================================================
# ENDPOINTS - SYSTÈME (Santé, Racine, Arrêt)
# ============================================================================

@router.get("/healthz")
async def health_check():
    """Vérification de santé simple pour les services d'hébergement."""
    # Pourrait être étendu pour vérifier la connexion DB, état du modèle ML, etc.
    model_loaded = "sentence_transformer" in ml_models
    logging.debug(f"Health check: Modèle ML chargé: {model_loaded}")
    return {"status": "ok", "model_loaded": model_loaded}

@router.get("/")
def read_root():
    """Endpoint racine, retourne un statut simple."""
    logging.info("Accès à l'endpoint racine.")
    return {"status": "Nihon Quest Backend Fonctionnel", "version": "1.1"} # Mettre à jour la version si nécessaire

# Attention: Endpoint potentiellement dangereux en production
# @router.post("/shutdown")
# async def shutdown_server():
#     """Arrête le serveur FastAPI (pourrait être utile en dev, risqué en prod)."""
#     logging.warning("Arrêt du serveur demandé via l'endpoint /shutdown.")
#     # Envoyer un signal SIGTERM au processus courant pour un arrêt propre
#     os.kill(os.getpid(), signal.SIGTERM)
#     # Cette réponse ne sera probablement jamais envoyée car le serveur s'arrête avant
#     return {"message": "Arrêt du serveur initié."}