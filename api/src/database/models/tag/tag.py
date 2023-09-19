from datetime import datetime
from sqlalchemy import (
    JSON,
    Boolean,
    ForeignKey,
    Integer,
    String,
    Column,
    Text,
    DateTime,
)
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.tag.tag_group import TagGroup


class Tag(Base):
    __tablename__ = "tags"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=True, unique=True)
    details = Column(JSON, nullable=True)

    group_id = Column(Integer, ForeignKey(TagGroup.id))

    group = relationship(TagGroup, backref="tags")
