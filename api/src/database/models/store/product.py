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
from src.database.models.store.store import Store


class Product(Base):
    __tablename__ = "products"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=True)
    description = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    preview_img = Column(String(255), nullable=True)
    details = Column(JSON, nullable=True)
    is_service = Column(Boolean, default=False, nullable=True)

    store_id = Column(Integer, ForeignKey(Store.id))

    store = relationship(Store, backref="products")

    @hybrid_property
    def count_items(self):
        count = 0
        for p_i in self.product_items:
            count += p_i.count
        return count

    @hybrid_property
    def price_info(self):
        price_min, price_max = -1, -1
        for p_i in self.product_items:
            if p_i.price is not None:
                price_now = p_i.price
                if price_min == -1 or price_min > price_now:
                    price_min = price_now
                if price_max == -1 or price_max < price_now:
                    price_max = price_now
        return {"price_max": price_max, "price_min": price_min}

    @hybrid_property
    def rating(self):
        count = 0
        mark = 0
        for p_f in self.product_feedbacks:
            count += 1
            mark += p_f.mark
        return mark // count if count != 0 else None
