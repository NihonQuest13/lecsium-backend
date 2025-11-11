from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.pool import NullPool
import os
import logging
from typing import Generator

logger = logging.getLogger(__name__)

# Database configuration
DB_USER = os.environ.get('DB_USER')
DB_PASS = os.environ.get('DB_PASS')
DB_NAME = os.environ.get('DB_NAME')
DB_HOST = os.environ.get('DB_HOST')  # This is the path '/cloudsql/...'

if DB_HOST:
    # Configuration for Google Cloud SQL (via Cloud Run)
    DATABASE_URL = f"postgresql+pg8000://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME}"
else:
    # Fallback for local development
    DATABASE_URL = os.environ.get('DATABASE_URL', "postgresql://user:password@localhost/nihon_quest")

# Create engine with connection pooling disabled for Cloud SQL
engine = create_engine(
    DATABASE_URL,
    poolclass=NullPool,  # Disable pooling for Cloud SQL
    echo=False,  # Set to True for SQL query logging in development
)

# Create SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db() -> Generator[Session, None, None]:
    """Dependency to get database session."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def init_db():
    """Initialize database tables."""
    from .models import Base
    Base.metadata.create_all(bind=engine)
    logger.info("Database tables initialized.")

def get_db_session() -> Session:
    """Get a database session for manual use."""
    return SessionLocal()
