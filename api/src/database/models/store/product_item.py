from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.store.product import Product


class ProductItem(Base):
    __tablename__ = "product_items"
    id = Column(Integer, primary_key=True)
    price = Column(Integer, nullable=True)
    name = Column(String(255), nullable=True)
    details = Column(JSON, nullable=True)
    count = Column(Integer, default=0)

    product_id = Column(Integer, ForeignKey(Product.id))

    product = relationship(Product, backref='product_items')
