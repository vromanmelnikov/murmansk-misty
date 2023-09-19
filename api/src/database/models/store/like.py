from datetime import datetime
from sqlalchemy import JSON, Boolean, ForeignKey, Integer, String, Column, Text, DateTime
from sqlalchemy.orm import relationship

from src.database.base import Base
from src.database.models.store.product_feedback import ProductFeedback
from src.database.models.users.user import User


class Like(Base):
    __tablename__ = "likes"

    user_id = Column(Integer, ForeignKey(User.id), primary_key=True)
    product_feedback_id = Column(Integer, ForeignKey(ProductFeedback.id), primary_key=True)

    product_feedback = relationship(ProductFeedback, backref="likes")
    user = relationship(User, backref="likes")