from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, Boolean, Table
from sqlalchemy.orm import relationship, declarative_base
from datetime import datetime

Base = declarative_base()

# Association table for novel collaborators
novel_collaborators = Table(
    'novel_collaborators',
    Base.metadata,
    Column('novel_id', Integer, ForeignKey('novels.id'), primary_key=True),
    Column('user_id', Integer, ForeignKey('users.id'), primary_key=True)
)

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    firebase_uid = Column(String(255), unique=True, nullable=False, index=True)
    email = Column(String(255), unique=True, nullable=False)
    display_name = Column(String(255))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    novels = relationship("Novel", back_populates="author")
    friendships_sent = relationship("Friendship", foreign_keys="Friendship.sender_id", back_populates="sender")
    friendships_received = relationship("Friendship", foreign_keys="Friendship.receiver_id", back_populates="receiver")
    collaborations = relationship("Novel", secondary=novel_collaborators, back_populates="collaborators")

class Novel(Base):
    __tablename__ = 'novels'

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    genre = Column(String(100))
    description = Column(Text)
    author_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    author = relationship("User", back_populates="novels")
    chapters = relationship("Chapter", back_populates="novel", cascade="all, delete-orphan")
    collaborators = relationship("User", secondary=novel_collaborators, back_populates="collaborations")

class Chapter(Base):
    __tablename__ = 'chapters'

    id = Column(Integer, primary_key=True, index=True)
    novel_id = Column(Integer, ForeignKey('novels.id'), nullable=False)
    chapter_number = Column(Integer, nullable=False)
    title = Column(String(255))
    content = Column(Text, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    novel = relationship("Novel", back_populates="chapters")

class Friendship(Base):
    __tablename__ = 'friendships'

    id = Column(Integer, primary_key=True, index=True)
    sender_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    receiver_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    status = Column(String(20), default='pending')  # pending, accepted, blocked
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    sender = relationship("User", foreign_keys=[sender_id], back_populates="friendships_sent")
    receiver = relationship("User", foreign_keys=[receiver_id], back_populates="friendships_received")
