import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.db.models import Base, User, Novel, Chapter, Friendship

# Use in-memory SQLite for testing
TEST_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(TEST_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def setup_module():
    """Create test database tables"""
    Base.metadata.create_all(bind=engine)

def teardown_module():
    """Drop test database tables"""
    Base.metadata.drop_all(bind=engine)

def test_user_model():
    """Test User model creation"""
    db = TestingSessionLocal()
    try:
        user = User(
            firebase_uid="test-uid",
            email="test@example.com",
            display_name="Test User"
        )
        db.add(user)
        db.commit()
        db.refresh(user)

        assert user.id is not None
        assert user.firebase_uid == "test-uid"
        assert user.email == "test@example.com"
    finally:
        db.close()

def test_novel_model():
    """Test Novel model creation"""
    db = TestingSessionLocal()
    try:
        user = User(firebase_uid="test-uid-novel", email="test-novel@example.com")
        db.add(user)
        db.commit()

        novel = Novel(
            title="Test Novel",
            description="A test novel",
            genre="fantasy",
            author_id=user.id
        )
        db.add(novel)
        db.commit()
        db.refresh(novel)

        assert novel.id is not None
        assert novel.title == "Test Novel"
        assert novel.author_id == user.id
    finally:
        db.close()
