# backend/app/core/lifespan.py
from contextlib import asynccontextmanager
from fastapi import FastAPI
from sentence_transformers import SentenceTransformer
import logging
import numpy as np
import os
import asyncio

# Disable tqdm progress bars to prevent OSError in threads
os.environ['TQDM_DISABLE'] = '1'

logger = logging.getLogger(__name__)

ml_models = {}
model_loaded = False

# Initialize database on startup
from app.db.connection import init_db

def load_model():
    """Charge le modèle d'IA de manière synchrone (lazy loading)."""
    global model_loaded
    if model_loaded:
        return
    try:
        logger.info("CHARGEMENT PARESSEUX: Démarrage du chargement du modèle d'IA.")
        os.environ['OMP_NUM_THREADS'] = '1'
        os.environ['TOKENIZERS_PARALLELISM'] = 'false'

        model = SentenceTransformer("all-MiniLM-L6-v2", device='cpu')
        ml_models["sentence_transformer"] = model
        model_loaded = True
        logger.info("CHARGEMENT PARESSEUX: Modèle d'IA chargé avec succès.")

        # Vérification simple
        test_sentence = ["Ceci est une phrase de test."]
        test_embedding = model.encode(test_sentence, show_progress_bar=False)
        if test_embedding.shape == (1, 384):
            logger.info("CHARGEMENT PARESSEUX: Test de vérification réussi. Le modèle est opérationnel.")
        else:
            raise ValueError(f"Dimension inattendue: {test_embedding.shape}")

    except Exception as e:
        logger.critical(f"ERREUR CRITIQUE: Échec du chargement du modèle — {e}", exc_info=True)

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Cycle de vie FastAPI optimisé - pas de chargement au démarrage."""
    logger.info("Démarrage du service web.")
    logger.info("Le serveur est prêt à répondre aux 'health checks'.")
    # Pas de chargement au démarrage - lazy loading uniquement

    yield  # ⬅️ FastAPI est prêt ici (Render pourra valider le /healthz)

    logger.info("Extinction de l'application... Nettoyage des modèles.")
    ml_models.clear()
    logger.info("Nettoyage terminé.")
