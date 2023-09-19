from datetime import datetime
from sqlalchemy import (
    JSON,
    Boolean,
    DateTime,
    ForeignKey,
    Integer,
    String,
    Column,
    Interval,
)
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.users.user import User


class Task(Base):
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True)
    name = Column(String(255))
    path = Column(String(255))
    is_active = Column(Boolean, default=True)
    date_execute = Column(DateTime(timezone=False), default=None)
    duration = Column(Interval)
    details = Column(JSON)
    user_id = Column(Integer, ForeignKey(User.id))
    last_date_execute = Column(DateTime(timezone=False), default=datetime.utcnow)

    user = relationship(User, backref="tasks")
