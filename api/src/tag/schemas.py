from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from src.database.models import *


class TagSchema(sqlalchemy_to_pydantic(Tag)):
    details: dict | None = None

    class Config:
        from_attributes = True


class TagGroupSchema(sqlalchemy_to_pydantic(TagGroup)):
    class Config:
        from_attributes = True


class TagWithGroupSchema(TagSchema):
    details: dict | None = None
    group: TagGroupSchema | None = None


class StoreTagLinkSchema(sqlalchemy_to_pydantic(StoreTagLink)):
    tag: TagSchema | None = None

    class Config:
        from_attributes = True


class ProductTagLinkSchema(sqlalchemy_to_pydantic(ProductTagLink)):
    tag: TagSchema | None = None

    class Config:
        from_attributes = True
