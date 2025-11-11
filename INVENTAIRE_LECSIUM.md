# Inventaire du Projet Lecsium
**Date :** 2025-11-11  
**Auteur :** BLACKBOXAI  
**Utilisateur GCP :** nathangrondin681@gmail.com  

## Vue d'ensemble
Projet Google Cloud "Lecsium" - Application pour la génération de romans japonais avec IA.  
- **ID Projet :** lecsium
- **Numéro Projet :** 547693779423
- **État :** ACTIVE
- **Créé le :** 2025-11-10T22:56:05.060134Z

---

## 1. Architecture Générale
- **Frontend :** Flutter (nihon_quest/)
- **Backend :** FastAPI (app/ - backend unifié)
- **Base de données :** PostgreSQL (Cloud SQL - instance unique)
- **Stockage :** Google Cloud Storage (avec UBLA activé)
- **Authentification :** Firebase
- **Déploiement :** Cloud Run, Docker
- **Secrets :** GCP Secret Manager

---

## 2. Services GCP Activés (Optimisés)
Liste complète des APIs/services activés (via `gcloud services list --enabled`) :
- Artifact Registry API (artifactregistry.googleapis.com)
- Gemini for Google Cloud API (cloudaicompanion.googleapis.com)
- Cloud Asset API (cloudasset.googleapis.com)
- Cloud Build API (cloudbuild.googleapis.com)
- Cloud Trace API (cloudtrace.googleapis.com)
- Compute Engine API (compute.googleapis.com)
- Container Registry API (containerregistry.googleapis.com)
- Identity and Access Management (IAM) API (iam.googleapis.com)
- IAM Service Account Credentials API (iamcredentials.googleapis.com)
- Cloud Logging API (logging.googleapis.com)
- Cloud Monitoring API (monitoring.googleapis.com)
- Cloud OS Login API (oslogin.googleapis.com)
- Cloud Pub/Sub API (pubsub.googleapis.com)
- Recommender API (recommender.googleapis.com)
- Cloud Run Admin API (run.googleapis.com)
- Secret Manager API (secretmanager.googleapis.com)
- Service Management API (servicemanagement.googleapis.com)
- Service Usage API (serviceusage.googleapis.com)
- Cloud SQL (sql-component.googleapis.com)
- Cloud SQL Admin API (sqladmin.googleapis.com)
- Google Cloud Storage JSON API (storage-api.googleapis.com)
- Cloud Storage (storage-component.googleapis.com)
- Cloud Storage API (storage.googleapis.com)

**Optimisations réalisées :** Désactivation de 14 APIs inutiles (BigQuery, Dataplex, etc.) - Économies ~20-30$/mois

---

## 3. Buckets Cloud Storage (UBLA Activé)
### lecsium-backup
- Location: US (multi-region)
- Usage: Sauvegardes
- Sécurité: UBLA activé

### lecsium-sql-imports
- Location: US-CENTRAL1
- Usage: Imports SQL
- Sécurité: UBLA activé

### lecsium_cloudbuild
- Location: US (multi-region)
- Usage: Cloud Build
- Sécurité: UBLA activé

### supabase-exports-lecsium
- Location: US-CENTRAL1
- Usage: Exports Supabase (backups SQL)
- Contenu: 2 fichiers backup récents
- Sécurité: UBLA activé

---

## 4. Instances Cloud SQL (Consolidées)
### lecsium-db-postgres (UNIQUE)
- Version: PostgreSQL 17
- Location: us-central1-a
- Tier: db-custom-2-8192
- IP: 35.225.106.204
- Backup: Activé (7 jours, PITR)
- SSL: ENCRYPTED_ONLY
- Database: postgres

**Optimisations réalisées :** Suppression de 2 DBs redondantes (`lecsium-db`, `nihon-quest-db`) - Économies ~50-70$/mois

---

## 5. Service Cloud Run
### lecsium-api
- URL: https://lecsium-api-547693779423.europe-west1.run.app
- Région: europe-west1
- Image: gcr.io/lecsium/lecsium-api:latest
- Mémoire: 1Gi, CPU: 1000m
- Scaling: 0-20 instances
- Timeout: 300s
- Variables d'environnement configurées (DB, API keys, etc.)

---

## 6. Comptes de Service
- 547693779423-compute@developer.gserviceaccount.com (Compute Engine)
- supabase-export-sa@lecsium.iam.gserviceaccount.com (Exports Supabase)

---

## 7. Secrets GCP (Secret Manager)
- openrouter-api-keys : Clés API OpenRouter
- deepl-api-keys : Clés API DeepL

**Optimisations réalisées :** Migration des secrets depuis variables d'environnement vers Secret Manager

---

## 8. Container Registry
- gcr.io/lecsium/lecsium-api (multiple tags, latest actif)

---

## 8. Endpoints API Principaux
Basé sur `app/api/router.py` :

### Génération IA
- `POST /generate_completion` : Génération non-streaming
- `POST /generate_chapter_stream` : Génération en streaming avec heartbeat
- `POST /generate_roadmap` : Mise à jour du résumé d'histoire

### Vector Store (Recherche sémantique)
- `POST /index_chapter` : Indexation chapitre (FAISS + GCS)
- `POST /get_context` : Recherche contextuelle
- `POST /delete_novel_storage` : Suppression stockage roman
- `POST /delete_chapter_from_index` : Suppression chapitre index
- `GET /list_indexed_novels` : Liste romans indexés

### CRUD Novels
- `GET /novels` : Liste romans utilisateur
- `POST /novels` : Création roman
- `GET /novels/{id}` : Détails roman + chapitres
- `PUT /novels/{id}` : Mise à jour roman
- `DELETE /novels/{id}` : Suppression roman
- `POST /novels/{id}/chapters` : Ajout chapitre

### CRUD Friends
- `GET /friends` : Liste amis
- `POST /friends/send-request` : Envoi demande ami
- `POST /friends/accept-request` : Acceptation demande

### CRUD Sharing
- `GET /novels/{id}/collaborators` : Liste collaborateurs
- `POST /novels/{id}/share` : Partage roman

### Autres
- `POST /translate` : Traduction DeepL
- `POST /auth/verify-token` : Vérification token Firebase
- `GET /healthz` : Health check
- `GET /` : Endpoint racine

## 9. Modèles de Données (SQLAlchemy)
Basé sur `app/db/models.py` :

### User
- id, firebase_uid (unique), email (unique), display_name
- Relations: novels (auteur), friendships (envoyées/reçues), collaborations

### Novel
- id, title, genre, description, author_id (FK User)
- Relations: author, chapters, collaborators (many-to-many via novel_collaborators)

### Chapter
- id, novel_id (FK), chapter_number, title, content
- Relations: novel

### Friendship
- id, sender_id (FK User), receiver_id (FK User), status (pending/accepted/blocked)
- Relations: sender, receiver

### novel_collaborators (Table d'association)
- novel_id (FK Novel), user_id (FK User)

## 10. Configuration Sécurité
- **CORS** : Origines autorisées spécifiques (localhost:3000, nihon-quest.pages.dev, etc.)
- **Authentification** : Firebase JWT via middleware
- **SSL Cloud SQL** : ENCRYPTED_ONLY
- **IAM** : Comptes de service dédiés
- **Variables d'environnement** : Clés API stockées de manière sécurisée

## 11. Dépendances (Versions Épinglées)
### Backend Python (requirements.txt)
- fastapi==0.104.1, uvicorn==0.24.0
- sqlalchemy==2.0.23, psycopg2-binary==2.9.9, pg8000==1.30.3
- firebase-admin==6.2.0
- sentence-transformers==2.2.2, faiss-cpu==1.7.4
- httpx==0.25.2, deepl==1.15.0
- google-cloud-storage==2.10.0
- pydantic, python-multipart

**Optimisations réalisées :** Versions épinglées pour stabilité et sécurité

### Frontend Flutter (pubspec.yaml)
- firebase_core: 4.2.1, firebase_auth: 6.1.2
- http: 1.5.0, flutter_riverpod: 2.5.1
- shared_preferences: 2.2.3, intl: 0.19.0
- cupertino_icons: 1.0.6, file_picker: 8.0.0
- collection: 1.18.0, excel: 4.0.2
- flutter_dotenv: 5.0.2, cached_network_image: 3.3.0
- flutter_markdown: 0.7.1, url_launcher: 6.3.0
- language_tool: 2.2.0, path_provider: 2.1.3
- path: 1.9.0

**Optimisations réalisées :** Versions épinglées pour stabilité et sécurité

## 12. Fonctionnalités Application (Résumé)
### Frontend Flutter
- Pages: Accueil, Bibliothèque, Lecteur, Création, Profil, Amis, etc.
- Services: IA, Feedback, Traduction, Cohérence, etc.
- Modèles: Novel, Chapter, User, Friendship, etc.

### Backend FastAPI
- Endpoints: Génération IA, Vector Store, CRUD Novels/Chapitres/Amis
- Auth: Firebase JWT
- ML: SentenceTransformers (chargement paresseux)
- Stockage: FAISS index + JSON sur GCS

### Base de Données
- Tables: users, novels, chapters, friendships, novel_collaborators
- ORM: SQLAlchemy
- Migrations: Alembic

## 13. Nettoyage des Référentiels Git
### Référentiel Principal (lecsium-backend)
- **URL :** https://github.com/NihonQuest13/lecsium-backend
- **Branches actives :** main (locale et distante)
- **Branches supprimées :** blackboxai/update-frontend

### Sous-module Frontend (nihon-quest)
- **URL :** https://github.com/NihonQuest13/nihon-quest-frontend
- **Branches actives :** main (locale et distante)
- **Branches supprimées :** master (branche distante)

**Optimisations réalisées :** Suppression des branches inutiles et redondantes pour maintenir un historique propre

---

## Notes Techniques
- API OpenRouter pour génération IA
- DeepL pour traduction
- GCS pour stockage vectoriel (FAISS)
- Firebase pour authentification
- Cloud Run pour déploiement serverless
- PostgreSQL pour données relationnelles

## Résumé des Optimisations GCP et Maintenance
- **Économies totales estimées :** ~70-100$/mois
  - Désactivation APIs inutiles : ~20-30$/mois
  - Consolidation DBs : ~50-70$/mois
- **Sécurité renforcée :** UBLA activé, secrets dans Secret Manager, versions épinglées
- **Performance :** Backend unifié, dépendances stables
- **Maintenance :** Architecture simplifiée, monitoring activé, référentiels Git nettoyés

---

*Inventaire mis à jour avec optimisations GCP. Dernière mise à jour: 2025-11-11*
