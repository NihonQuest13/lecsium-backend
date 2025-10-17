# backend/app/core/lifespan.py
from contextlib import asynccontextmanager
from fastapi import FastAPI
from sentence_transformers import SentenceTransformer
import logging
import numpy as np
import os

# Configuration du logging pour le backend
logger = logging.getLogger(__name__)

# Le dictionnaire qui agira comme un cache pour nos modèles d'IA
ml_models = {}

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Gestionnaire de cycle de vie pour l'application FastAPI.
    Ce code s'exécute au démarrage et à l'arrêt du serveur.
    """
    # --- Chargement du modèle au démarrage (Eager Loading) ---
    logger.info("Démarrage de l'application... Chargement du modèle d'IA en cours.")
    
    os.environ['OMP_NUM_THREADS'] = '1'
    os.environ['TOKENIZERS_PARALLELISM'] = 'false'
    
    try:
        model = SentenceTransformer("all-MiniLM-L6-v2", device='cpu')
        ml_models["sentence_transformer"] = model
        logger.info("Modèle d'IA chargé avec succès.")

        logger.info("Exécution d'un test de vérification du modèle...")
        test_sentence = ["Ceci est une phrase de test."]
        test_embedding = model.encode(test_sentence)
        
        expected_shape = (1, 384)
        if test_embedding.shape == expected_shape:
            logger.info(f"Test de vérification du modèle réussi. Le modèle est opérationnel (vecteur de forme {test_embedding.shape}).")
        else:
            raise ValueError(f"La dimension du vecteur de test est incorrecte. Attendu: {expected_shape}, Obtenu: {test_embedding.shape}")

    except Exception as e:
        logger.critical(f"ERREUR CRITIQUE: Impossible d'initialiser le modèle d'IA: {e}", exc_info=True)
        # Si le modèle ne peut pas être chargé, l'application ne doit pas continuer.
        # Lever une exception ici arrêtera le processus de démarrage de FastAPI.
        raise RuntimeError("Le modèle d'IA n'est pas opérationnel.") from e

    # L'application est maintenant prête à recevoir des requêtes.
    yield

    # --- Code exécuté à l'extinction de l'application ---
    logger.info("Extinction de l'application... Nettoyage des modèles.")
    ml_models.clear()
    logger.info("Nettoyage terminé.")