from datetime import datetime
from sqlalchemy import JSON, Boolean, Integer, String, Column, Text, DateTime

from src.database.base import Base


class TagGroup(Base):
    __tablename__ = "tag_groups"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=True, unique=True)
    details = Column(JSON, nullable=True)
