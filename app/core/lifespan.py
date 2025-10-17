# backend/app/core/lifespan.py
from contextlib import asynccontextmanager
from fastapi import FastAPI
from sentence_transformers import SentenceTransformer
import logging
import numpy as np
import os
import asyncio

logger = logging.getLogger(__name__)

ml_models = {}

def load_model():
    """Charge le modèle d'IA de manière synchrone (appelé dans un thread)."""
    try:
        logger.info("TÂCHE DE FOND: Démarrage du chargement du modèle d'IA.")
        os.environ['OMP_NUM_THREADS'] = '1'
        os.environ['TOKENIZERS_PARALLELISM'] = 'false'

        model = SentenceTransformer("all-MiniLM-L6-v2", device='cpu')
        ml_models["sentence_transformer"] = model
        logger.info("TÂCHE DE FOND: Modèle d'IA chargé avec succès.")

        # Vérification simple
        test_sentence = ["Ceci est une phrase de test."]
        test_embedding = model.encode(test_sentence)
        if test_embedding.shape == (1, 384):
            logger.info("TÂCHE DE FOND: Test de vérification réussi. Le modèle est opérationnel.")
        else:
            raise ValueError(f"Dimension inattendue: {test_embedding.shape}")

    except Exception as e:
        logger.critical(f"ERREUR CRITIQUE: Échec du chargement du modèle — {e}", exc_info=True)

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Cycle de vie FastAPI adapté à Render."""
    logger.info("Démarrage du service web... Le serveur est prêt à répondre aux 'health checks'.")

    async def delayed_load():
        # Délai de 2 secondes pour laisser Render faire son health check avant le CPU spike
        await asyncio.sleep(2)
        await asyncio.to_thread(load_model)

    asyncio.create_task(delayed_load())

    yield  # ⬅️ FastAPI est prêt ici (Render pourra valider le /healthz)

    logger.info("Extinction de l'application... Nettoyage des modèles.")
    ml_models.clear()
    logger.info("Nettoyage terminé.")
