from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.store.product import Product
from src.database.models.tag.tag import Tag


class ProductTagLink(Base):
    __tablename__ = "product_tag_links"

    product_id = Column(Integer, ForeignKey(Product.id), primary_key=True)
    tag_id = Column(Integer, ForeignKey(Tag.id), primary_key=True)

    product = relationship(Product, backref='product_tag_links')
    tag = relationship(Tag, backref='product_tag_links')