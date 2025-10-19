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
origins = [
    # --- AJOUT DE VOTRE URL SPECIFIQUE ---
    "https://nihon-quest-frontend.pages.dev", 
    # --- FIN DE L'AJOUT ---

    # Mettez ici vos domaines de production (HTTPS)
    "https://nihonquest.pages.dev",
    "https://www.nihonquest.pages.dev",
    "https://nihon-quest-api.onrender.com",
    
    # Versions HTTP (non-sécurisées) pour la production.
    "http://nihonquest.pages.dev",
    "http://www.nihonquest.pages.dev",

    # Adresses pour le développement local
    "http://localhost",
    "http://localhost:8080",
    
    # Wildcards pour les "preview URLs" de Cloudflare (en HTTPS et HTTP)
    "https://*.pages.dev",
    "http://*.pages.dev",
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