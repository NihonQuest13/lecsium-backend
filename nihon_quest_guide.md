# Nihon Quest - Guide Complet

## Vue d'ensemble
Nihon Quest est une application Flutter pour l'écriture de romans assistée par IA. Elle comprend un frontend Flutter et un backend FastAPI Python.

## Repositories GitHub
- **Frontend** : [https://github.com/NihonQuest13/lecsium-frontend](https://github.com/NihonQuest13/lecsium-frontend)
- **Backend** : [https://github.com/NihonQuest13/lecsium-backend](https://github.com/NihonQuest13/lecsium-backend)

## Structure du Projet
```
Lecsium/
├── nihon_quest/          # Frontend Flutter
│   ├── lib/             # Code source Dart
│   ├── pubspec.yaml     # Dépendances Flutter
│   └── launcher.py      # Lanceur Python pour démarrage simultané
└── nihon_quest_backend/  # Backend Python
    ├── app/             # Code source FastAPI
    ├── requirements.txt # Dépendances Python
    └── Dockerfile       # Configuration déploiement
```

## Démarrage Local

### Backend
Le backend fonctionne maintenant avec SQLite pour le développement local.

**Commande de démarrage :**
```bash
python -c "import sys; sys.path.insert(0, 'nihon_quest_backend'); from app.main import app; import uvicorn; uvicorn.run(app, host='127.0.0.1', port=8000)"
```

**Vérification :**
- API racine : http://127.0.0.1:8000 → `{"status":"Nihon Quest Backend Fonctionnel","version":"1.3"}`
- Health check : http://127.0.0.1:8000/healthz → `{"status":"ok","model_loaded":false}`

### Frontend
```bash
cd nihon_quest
flutter run -d chrome
```

### Démarrage Combiné
Utilisez le lanceur Python `nihon_quest/launcher.py` qui démarre backend et frontend simultanément.

## Fonctionnalités

### Backend (FastAPI)
- **Génération IA** : Streaming de texte via OpenRouter
- **Vector Store** : Recherche sémantique avec FAISS
- **Traduction** : Support DeepL
- **Authentification** : JWT Firebase
- **CRUD Romans** : Gestion complète des romans/chapitres
- **Stockage** : Local ou Google Cloud Storage

### Frontend (Flutter)
- **Authentification** : Firebase Auth
- **Éditeur de Roman** : Interface pour écrire avec IA
- **Bibliothèque** : Gestion des romans
- **Lecteur** : Streaming des chapitres générés

## Configuration

### Variables d'environnement (optionnel)
```bash
# Backend
OPENROUTER_API_KEYS=your_key_here
DEEPL_API_KEY=your_key_here
DATABASE_URL=sqlite:///./nihon_quest.db

# Frontend
FIREBASE_CONFIG=your_config
```

## Déploiement

### Backend (Google Cloud Run)
- Configuration dans `Dockerfile`
- Déploiement automatique via Git
- Base de données SQLite (simple et efficace pour le développement)
- URL : `https://lecsium-api-547693779423.europe-west1.run.app`

### Frontend (Firebase Hosting)
- Configuration dans `firebase.json` et `.firebaserc`
- Déploiement automatique via GitHub Actions (nécessite configuration du secret FIREBASE_SERVICE_ACCOUNT_LECSIUM_5BAB1)
- Domaine : `https://lecsium-5bab1.web.app`
- **Note importante** : Un push GitHub ne suffit pas forcément pour déclencher le déploiement Firebase. Le workflow GitHub Actions doit être configuré avec les secrets appropriés pour que le déploiement automatique fonctionne.

## Développement

### Tests Backend
```bash
# Health check
curl http://127.0.0.1:8000/healthz

# API racine
curl http://127.0.0.1:8000
```

### Tests Frontend
```bash
cd nihon_quest
flutter test
```

## Dépannage

### Backend
- **Erreur PostgreSQL** : Le backend utilise maintenant SQLite par défaut
- **ImportError** : Vérifiez PYTHONPATH
- **Port occupé** : Tuez les processus sur le port 8000

### Frontend
- **Flutter doctor** : Vérifiez l'installation Flutter
- **Chrome non trouvé** : Installez Chrome ou utilisez un autre device

## Architecture Technique

### Backend
- **Framework** : FastAPI + Uvicorn
- **IA** : OpenRouter API
- **Embeddings** : SentenceTransformers
- **Vector DB** : FAISS
- **Stockage** : Local/GCS
- **Auth** : Firebase JWT

### Frontend
- **Framework** : Flutter
- **State** : Riverpod
- **Auth** : Firebase
- **UI** : Material Design
- **Networking** : HTTP client

## Sécurité
- Authentification Firebase obligatoire
- CORS configuré pour domaines spécifiques
- Validation des entrées API
- Gestion sécurisée des clés API

## Performance
- Streaming pour génération IA
- Cache des modèles ML
- Pooling de connexions DB
- Optimisation des requêtes vectorielles

## Support
Pour les problèmes, vérifiez les logs :
- Backend : Console du serveur
- Frontend : Console Chrome DevTools
