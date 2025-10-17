# backend/app/core/lifespan.py
from contextlib import asynccontextmanager
from fastapi import FastAPI
from sentence_transformers import SentenceTransformer
import logging
import numpy as np
import os
import asyncio # Pour les tâches de fond

logger = logging.getLogger(__name__)

# Le dictionnaire qui agira comme un cache pour nos modèles d'IA
ml_models = {}

def load_model():
    """
    Fonction synchrone qui charge le modèle. C'est la tâche lourde.
    Elle est lancée en arrière-plan et ne bloque pas le démarrage du serveur.
    """
    try:
        logger.info("TÂCHE DE FOND: Démarrage du chargement du modèle d'IA.")
        os.environ['OMP_NUM_THREADS'] = '1'
        os.environ['TOKENIZERS_PARALLELISM'] = 'false'
        
        model = SentenceTransformer("all-MiniLM-L6-v2", device='cpu')
        ml_models["sentence_transformer"] = model
        logger.info("TÂCHE DE FOND: Modèle d'IA chargé avec succès.")

        logger.info("TÂCHE DE FOND: Exécution d'un test de vérification du modèle...")
        test_sentence = ["Ceci est une phrase de test."]
        test_embedding = model.encode(test_sentence)
        
        expected_shape = (1, 384)
        if test_embedding.shape == expected_shape:
            logger.info(f"TÂCHE DE FOND: Test de vérification réussi. Le modèle est opérationnel.")
        else:
            raise ValueError(f"La dimension du vecteur de test est incorrecte. Attendu: {expected_shape}, Obtenu: {test_embedding.shape}")

    except Exception as e:
        logger.critical(f"ERREUR CRITIQUE PENDANT LE CHARGEMENT EN FOND: {e}", exc_info=True)
        # On ne crashe pas le serveur, mais les futures requêtes utilisant le modèle échoueront.

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Gestionnaire de cycle de vie qui lance le chargement du modèle en arrière-plan.
    """
    logger.info("Démarrage du service web... Le serveur est prêt à répondre aux 'health checks'.")
    # On lance la fonction lourde 'load_model' dans un thread séparé.
    # Le serveur ne l'attend pas et peut répondre immédiatement à /healthz.
    asyncio.create_task(asyncio.to_thread(load_model))
    
    # L'application est maintenant prête à recevoir des requêtes.
    yield

    # Code exécuté à l'extinction
    logger.info("Extinction de l'application... Nettoyage des modèles.")
    ml_models.clear()
    logger.info("Nettoyage terminé.")