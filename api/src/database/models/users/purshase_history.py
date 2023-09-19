from sqlalchemy import DateTime, ForeignKey, Integer, Column
from sqlalchemy.orm import relationship
from datetime import datetime

from src.database.base import Base
from src.database.models.store.product_item import ProductItem
from src.database.models.users.user import User


class PurshaseHistory(Base):
    __tablename__ = "purshase_histories"
    id = Column(Integer, primary_key=True)
    count = Column(Integer, nullable=False)
    price = Column(Integer, nullable=False)
    date = Column(DateTime, default=datetime.utcnow)

    user_id = Column(Integer, ForeignKey(User.id))
    product_item_id = Column(Integer, ForeignKey(ProductItem.id))

    user = relationship(User, backref="purshase_histories")
    product_item = relationship(ProductItem, backref="purshase_histories")