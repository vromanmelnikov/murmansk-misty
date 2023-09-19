from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base


class Characteristic(Base):
    __tablename__ = "characteristics"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
