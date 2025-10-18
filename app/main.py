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
# C'est la partie la plus importante pour résoudre votre problème.
# Elle autorise votre application frontend à communiquer avec ce backend.
origins = [
    "*"  # En production, vous devriez limiter à votre domaine Cloudflare
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],  # Autorise toutes les méthodes (GET, POST, etc.)
    allow_headers=["*"],  # Autorise tous les en-têtes
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
