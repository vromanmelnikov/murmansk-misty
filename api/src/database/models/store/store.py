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
from sqlalchemy.ext.hybrid import hybrid_property

from src.database.base import Base
from src.database.models.users.user import User
from sqlalchemy.orm import relationship


class Store(Base):
    __tablename__ = "stores"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=True)
    description = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    img = Column(String(255), nullable=True)
    is_active = Column(Boolean, nullable=True)
    address = Column(Text, nullable=True)
    coordinates = Column(JSON, nullable=True)
    site = Column(Text, nullable=True)
    details = Column(JSON, nullable=True)

    owner_id = Column(Integer, ForeignKey(User.id))

    owner = relationship(User, backref="stores")

    @hybrid_property
    def rating(self):
        count_prod = 0
        mark_prod = 0
        for p in self.products:
            count_prod += 1
            count = 0
            mark = 0
            for p_f in p.product_feedbacks:
                count += 1
                mark += p_f.mark
            mark_prod += mark // count if count != 0 else 0
            return mark_prod // count_prod if count_prod != 0 and mark_prod != 0 else None
