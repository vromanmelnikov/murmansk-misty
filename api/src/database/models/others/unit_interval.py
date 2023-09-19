from sqlalchemy import JSON,Integer, String, Column

from src.database.base import Base


class UnitInterval(Base):
    __tablename__ = "unit_intervals"

    id = Column(Integer, primary_key=True)
    name = Column(String(255), unique=True)
    unit = Column(String(255), unique=True)
    value = Column(Integer)
    
    details = Column(JSON)
