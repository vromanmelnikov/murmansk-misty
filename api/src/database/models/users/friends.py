from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.users.user import User


class Friend(Base):
    __tablename__ = "friends"
    type = Column(String(255), nullable=True)

    initator_id = Column(Integer, ForeignKey(User.id), primary_key=True)
    friend_id = Column(Integer, ForeignKey(User.id), primary_key=True)

    initiator = relationship(User, foreign_keys=initator_id, backref='friends')
    friend = relationship(User, foreign_keys=friend_id, backref='initiators')
