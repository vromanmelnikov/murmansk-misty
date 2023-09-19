from sqlalchemy import (
    Boolean,
    Column,
    ForeignKey,
    Integer,
    String,
    Date,
    DateTime,
    Text,
)
from sqlalchemy.orm import relationship
from datetime import datetime

from src.const import REPOSITORY_USERS
from src.database.base import Base
from src.database.models.users.role import Role


class User(Base):
    __tablename__ = REPOSITORY_USERS
    id = Column(Integer, primary_key=True)
    email = Column(String(320), nullable=False, unique=True)
    hashed_password = Column(String(1024), nullable=False)
    
    firstname = Column(String(100), nullable=True)
    lastname = Column(String(100), nullable=True)
    patronymic = Column(String(100), nullable=True)
    birthdate = Column(Date, nullable=True)
    img = Column(Text, nullable=True)
    gender = Column(Boolean, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    role_id = Column(Integer, ForeignKey(Role.id))
    cash = Column(Integer, default=0)

    role = relationship(Role, backref="users")
