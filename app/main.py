from fastapi import FastAPI
from app.api.router import router as api_router
from app.core.lifespan import lifespan
from fastapi.middleware.cors import CORSMiddleware
import logging
import re

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(lifespan=lifespan)

# ✅ CORRECTION CORS : Utiliser allow_origin_regex au lieu de wildcards
app.add_middleware(
    CORSMiddleware,
    allow_origin_regex=r"https://.*\.pages\.dev",  # ✅ Accepte tous les sous-domaines .pages.dev
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ ALTERNATIVE : Si le regex ne marche pas, utiliser "*" (accepte tout)
# C'est moins sécurisé mais garantit que ça fonctionne
# app.add_middleware(
#     CORSMiddleware,
#     allow_origins=["*"],
#     allow_credentials=False,  # ⚠️ Doit être False si allow_origins=["*"]
#     allow_methods=["*"],
#     allow_headers=["*"],
# )

app.include_router(api_router)

@app.get("/ping")
async def ping():
    """
    Un endpoint simple pour vérifier que le serveur est en ligne.
    """
    logger.info("Ping endpoint was called")
    return {"message": "pong"}

logger.info("Application startup complete.")