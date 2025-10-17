@echo off
setlocal
echo --- Script de compilation Nuitka (Version Finale et Complete) ---
echo.

REM --- Activation de l'environnement ---
call .\venv\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo ERREUR: Impossible d'activer l'environnement virtuel.
    pause
    exit /b %errorlevel%
)
echo.

REM --- Installation/Mise à jour des dépendances ---
echo Mise a jour des dependances depuis requirements.txt...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERREUR: L'installation des dependances a echoue.
    pause
    exit /b %errorlevel%
)
echo.

REM --- Compilation ---
echo Lancement de la compilation Nuitka...
echo.

REM On se fie aux options --include-package-data qui sont plus robustes
REM pour inclure automatiquement le modèle et ses dépendances.
.\venv\Scripts\python.exe -m nuitka ^
    --standalone ^
    --remove-output ^
    --follow-imports ^
    --include-package=sklearn ^
    --include-package-data=sklearn ^
    --include-package=torch ^
    --include-distribution-metadata=torch ^
    --include-distribution-metadata=torchaudio ^
    --include-distribution-metadata=torchvision ^
    --include-package-data=sentence_transformers ^
    --include-package-data=transformers ^
    --include-package-data=tokenizers ^
    --include-package-data=huggingface_hub ^
    --include-package=msgpack_asgi ^
    --output-dir=..\release\backend ^
    --output-filename=backend_service ^
    app\main.py

if %errorlevel% neq 0 (
    echo.
    echo ERREUR: La compilation Nuitka a echoue.
    pause
    exit /b %errorlevel%
)
echo.
echo Compilation reussie !
echo.

REM --- Copie des fichiers additionnels ---
if exist "storage" (
    xcopy /E /I /Y "storage" "..\release\backend\storage\" >nul
    echo Dossier 'storage' copie.
)
echo.

echo --- Compilation du Backend terminee avec succes ! ---
pause
endlocal