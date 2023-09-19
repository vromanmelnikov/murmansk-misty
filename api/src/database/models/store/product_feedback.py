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
from sqlalchemy.ext.hybrid import hybrid_property

from src.database.base import Base
from src.database.models.store.product import Product
from src.database.models.users.user import User


class ProductFeedback(Base):
    __tablename__ = "product_feedbacks"
    id = Column(Integer, primary_key=True)
    mark = Column(Integer, nullable=True)
    review = Column(Text, nullable=True)

    user_id = Column(Integer, ForeignKey(User.id))
    product_id = Column(Integer, ForeignKey(Product.id))

    user = relationship(User, backref="product_feedbacks")
    product = relationship(Product, backref="product_feedbacks")

    @hybrid_property
    def like_count(self):
        return len(self.likes)
