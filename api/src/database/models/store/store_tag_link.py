from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.tag.tag import Tag
from src.database.models.store.store import Store


class StoreTagLink(Base):
    __tablename__ = "store_tag_links"

    store_id = Column(Integer, ForeignKey(Store.id), primary_key=True)
    tag_id = Column(Integer, ForeignKey(Tag.id), primary_key=True)

    tag = relationship(Tag, backref='store_tag_links')
    store = relationship(Store, backref='store_tag_links')
