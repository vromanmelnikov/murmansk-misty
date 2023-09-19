from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime

from src.database.base import Base


class FriendType(Base):
    __tablename__ = "friend_types"
    id = Column(Integer, primary_key=True)

    name = Column(Text, nullable=True)
