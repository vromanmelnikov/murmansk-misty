from datetime import datetime
from sqlalchemy.orm import relationship
from sqlalchemy import JSON, DateTime, ForeignKey, Integer, Column, Text

from src.database.base import Base
from src.database.models.users.user import User


class NoteModel(Base):
    __tablename__ = "notes"

    id = Column(Integer, primary_key=True)
    text = Column(Text, primary_key=True)
    user_id = Column(Integer, ForeignKey(User.id))
    created_at = Column(DateTime, default=datetime.utcnow)
    details = Column(JSON)

    owner = relationship(User, backref="notes")
