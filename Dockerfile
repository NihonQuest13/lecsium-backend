# 1. Utiliser l'image Python 3.11 (slim)
FROM python:3.11-slim

# 2. Définir le répertoire de travail
WORKDIR /app

# 3. Copier les dépendances
COPY requirements.txt .

# 4. Installer les dépendances
# Note : --no-cache-dir est important pour garder l'image légère
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copier tout le code de votre application
# (Copie le dossier 'app', 'main.py' [s'il est là], etc.)
COPY . .

# 6. Définir la commande de démarrage
# Cloud Run injecte la variable $PORT automatiquement.
CMD ["sh", "-c", "gunicorn -w 1 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT app.main:app"]
