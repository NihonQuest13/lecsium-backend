# backend/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
# contextlib n'est plus nécessaire ici
import logging

# Import de votre router
from app.api.router import router

# ✅ CORRECTION: On importe le 'lifespan' directement depuis votre fichier,
# ainsi que ml_models (au cas où le router en aurait besoin)
from app.core.lifespan import lifespan, ml_models

# Configuration du logging (style du nouveau code)
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# ❌ L'ancienne définition locale de lifespan est supprimée,
# car elle est maintenant importée de app.core.lifespan

# Création de l'application FastAPI (style du nouveau code)
app = FastAPI(
    title="Lecsium API",
    description="API Backend pour la génération de romans avec IA",
    version="1.0.0",
    lifespan=lifespan  # ✅ On utilise le 'lifespan' importé
)

# ✅ CONFIGURATION CORS SÉCURISÉE (optimisée pour légèreté)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",  # Développement local
        "http://127.0.0.1:3000",  # Développement local
        "https://nihon-quest.pages.dev",  # Domaine spécifique
        "https://nihon-quest-frontend.pages.dev",  # Frontend Cloudflare Pages
        "https://lecsium-5bab1.web.app",  # Firebase hosting domain
    ],
    allow_credentials=True,
    allow_methods=["GET", "POST", "OPTIONS"],  # Inclut OPTIONS pour preflight
    allow_headers=["*"],  # Headers standards
    expose_headers=[],  # Aucun header exposé
)

# Inclusion du router principal
app.include_router(router)

# Endpoint racine (remplace l'ancien /ping)
@app.get("/")
def read_root():
    return {
        "status": "Nihon Quest Backend Online",
        "version": "1.0.0",
        "message": "API fonctionnelle avec CORS activé"
    }

# Pour lancer le serveur en local :
# uvicorn main:app --host 0.0.0.0 --port 8000 --reload