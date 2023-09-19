from sqlalchemy import ForeignKey, Integer, Column
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.store.product_item import ProductItem
from src.database.models.users.user import User


class Favourite(Base):
    __tablename__ = "favourites"
    id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey(User.id))
    product_item_id = Column(Integer, ForeignKey(ProductItem.id))

    user = relationship(User, backref="favourites")
    product_item = relationship(ProductItem, backref="favourites")