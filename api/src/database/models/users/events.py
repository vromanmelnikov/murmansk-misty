from sqlalchemy import JSON, DateTime, ForeignKey, Integer, Column, String
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.users.user import User


class Event(Base):
    __tablename__ = "events"
    id = Column(Integer, primary_key=True)

    description = Column(String, nullable=True)
    time = Column(DateTime(timezone=True), nullable=False)
    details = Column(JSON, nullable=False)

    user_id = Column(Integer, ForeignKey(User.id))

    user = relationship(User, backref="events")
