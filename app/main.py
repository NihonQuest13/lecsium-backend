from fastapi import FastAPI
from app.api.router import router as api_router
from app.core.lifespan import lifespan
from fastapi.middleware.cors import CORSMiddleware
import logging

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(lifespan=lifespan)

# Configuration du middleware CORS
# MODIFIÉ : Remplacement de "*" par une liste d'origines explicites.
# C'est plus sécurisé et essentiel pour que Cloudflare et Render
# communiquent correctement en production.
origins = [
    # Mettez ici vos domaines de production
    "https://nihonquest.pages.dev",            # Votre URL Cloudflare
    "https://www.nihonquest.pages.dev",       # Avec www
    "https://nihon-quest-api.onrender.com",  # Votre URL Render
    
    # Adresses pour le développement local
    "http://localhost",
    "http://localhost:8080", # Port Flutter web local par défaut
    
    # Vous pouvez aussi autoriser les URL de preview de Cloudflare Pages
    "https://*.pages.dev",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,       # Utilise la liste définie ci-dessus
    allow_credentials=True,
    allow_methods=["*"],         # Autorise toutes les méthodes
    allow_headers=["*"],         # Autorise tous les en-têtes
)

app.include_router(api_router)

@app.get("/ping")
async def ping():
    """
    Un endpoint simple pour vérifier que le serveur est en ligne.
    """
    logger.info("Ping endpoint was called")
    return {"message": "pong"}

logger.info("Application startup complete.")