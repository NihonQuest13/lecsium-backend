from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.pool import NullPool
import os
import logging

logger = logging.getLogger(__name__)

# Database configuration
DATABASE_URL = os.environ.get('DATABASE_URL')
if not DATABASE_URL:
    # Fallback for local development - adjust as needed
    DATABASE_URL = "postgresql://user:password@localhost/nihon_quest"

# Create engine with connection pooling disabled for Cloud SQL
engine = create_engine(
    DATABASE_URL,
    poolclass=NullPool,  # Disable pooling for Cloud SQL
    echo=False,  # Set to True for SQL query logging in development
)

# Create SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db() -> Session:
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
