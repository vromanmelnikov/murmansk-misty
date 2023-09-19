from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.tag.tag import Tag
from src.database.models.users.user import User


class CustomerTagLink(Base):
    __tablename__ = "customer_tag_links"

    customer_id = Column(Integer, ForeignKey(User.id), primary_key=True)
    tag_id = Column(Integer, ForeignKey(Tag.id), primary_key=True)

    user = relationship(User, backref='tag_links')
    tag = relationship(Tag, backref='tag_links')
