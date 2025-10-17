# backend/app/main.py
import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware # <-- IMPORT NÉCESSAIRE
import sys
import os

# --- Correction pour l'exécution directe ---
if not getattr(sys, 'frozen', False):
    sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app.core.lifespan import lifespan
from app.api.router import router as api_router
# Note : msgpack n'est pas utilisé pour le streaming, donc on peut le retirer si ça cause des soucis.
# from msgpack_asgi import MessagePackMiddleware

# --- Configuration de logs Uvicorn (inchangée) ---
LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "default": {
            "()": "uvicorn.logging.DefaultFormatter",
            "fmt": "%(levelprefix)s %(message)s",
            "use_colors": False,
        },
        "access": {
            "()": "uvicorn.logging.AccessFormatter",
            "fmt": '%(levelprefix)s %(client_addr)s - "%(request_line)s" %(status_code)s',
        },
    },
    "handlers": {
        "default": {
            "formatter": "default",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stderr",
        },
        "access": {
            "formatter": "access",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stdout",
        },
    },
    "loggers": {
        "uvicorn": {"handlers": ["default"], "level": "INFO"},
        "uvicorn.error": {"level": "INFO"},
        "uvicorn.access": {"handlers": ["access"], "level": "INFO", "propagate": False},
    },
}

# --- Création de l'application FastAPI ---
app = FastAPI(lifespan=lifespan)

# --- CORRECTION CRUCIALE DE LA GESTION CORS ---
# On autorise toutes les origines. C'est parfait pour le développement local.
# En production, on remplacera "*" par l'URL de votre site web (ex: "https://mon-app.netlify.app")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"], # Autorise toutes les méthodes (GET, POST, OPTIONS...)
    allow_headers=["*"], # Autorise tous les en-têtes
)
# --- FIN DE LA CORRECTION ---

# app.add_middleware(MessagePackMiddleware)
app.include_router(api_router)

# --- Point d'entrée pour l'exécution ---
if __name__ == "__main__":
    # La commande 'uvicorn app.main:app --reload' utilise son propre port (8000)
    # Cette section est surtout pour l'exécution directe du fichier.
    uvicorn.run(app, host="127.0.0.1", port=8000, log_config=LOGGING_CONFIG)