from fastapi import Request, HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import firebase_admin
from firebase_admin import auth, credentials
import os
import logging
from typing import Optional

logger = logging.getLogger(__name__)

# Initialize Firebase Admin SDK
firebase_credentials_path = os.environ.get('FIREBASE_CREDENTIALS_PATH')
if firebase_credentials_path:
    cred = credentials.Certificate(firebase_credentials_path)
    firebase_admin.initialize_app(cred)
else:
    # For local development, use default credentials or service account key
    try:
        firebase_admin.initialize_app()
    except ValueError:
        # App already initialized
        pass

security = HTTPBearer()

async def verify_firebase_token(credentials: HTTPAuthorizationCredentials = Depends(security)) -> dict:
    """Verify Firebase JWT token and return decoded token."""
    try:
        token = credentials.credentials
        decoded_token = auth.verify_id_token(token)
        return decoded_token
    except auth.ExpiredIdTokenError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except auth.RevokedIdTokenError:
        raise HTTPException(status_code=401, detail="Token has been revoked")
    except auth.InvalidIdTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")
    except Exception as e:
        logger.error(f"Token verification error: {e}")
        raise HTTPException(status_code=401, detail="Token verification failed")

def get_current_user_uid(decoded_token: dict = Depends(verify_firebase_token)) -> str:
    """Extract user UID from decoded Firebase token."""
    return decoded_token.get('uid')

def get_current_user_email(decoded_token: dict = Depends(verify_firebase_token)) -> str:
    """Extract user email from decoded Firebase token."""
    return decoded_token.get('email', '')
