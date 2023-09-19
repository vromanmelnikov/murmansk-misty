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
from src.database.models.store.product import Product
from src.database.models.users.user import User


class ProductFavourite(Base):
    __tablename__ = "product_favourites"
    id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey(User.id))
    product_id = Column(Integer, ForeignKey(Product.id))

    user = relationship(User, backref="product_favourites")
    product = relationship(Product, backref="product_favourites")
