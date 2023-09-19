from sqlalchemy.orm import relationship
from sqlalchemy import JSON, ForeignKey, Integer, String, Column

from src.database.base import Base
from src.database.models.users.user import User


class FileModel(Base):
    __tablename__ = "files"

    token = Column(String(255), primary_key=True)
    owner_id = Column(Integer, ForeignKey(User.id))
    details = Column(JSON)

    owner = relationship(User, backref="files")
