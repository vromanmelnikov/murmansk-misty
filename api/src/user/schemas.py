from datetime import datetime
from pydantic import BaseModel, EmailStr, Field, SecretStr
from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from src.store.schemas import ProductSchemaForGet
from src.database.models import *
from src.store.schemas import (
    ProductItemSchema,
    ProductItemWithProduct,
    StoreGetUserSchema,
)
from src.tag.schemas import TagSchema


class RoleSchema(sqlalchemy_to_pydantic(Role)):
    details: dict | None = None

    class Config:
        from_attributes = True


class ResetEmailSchema(BaseModel):
    new_email: EmailStr


class UserDBSchema(sqlalchemy_to_pydantic(User)):
    firstname: str | None= None
    lastname: str | None= None
    patronymic: str | None= None
    birthdate: datetime | None = None
    img: str | None = None
    gender: bool | None = None

    class Config:
        from_attributes = True


class UserWithRoleSchema(UserDBSchema):
    hashed_password: str | SecretStr = Field(..., exclude=True)

    role: RoleSchema | None = None

    class Config:
        from_attributes = True
        exclude = ["hashed_password"]


class UserTagLinks(sqlalchemy_to_pydantic(CustomerTagLink)):
    tag: TagSchema | None = None

    class Config:
        from_attributes = True


class UserGetByIdSchema(UserWithRoleSchema):
    tag_links: list[UserTagLinks] = []
    stores: list[StoreGetUserSchema] = []


class FriendTypeSchema(sqlalchemy_to_pydantic(FriendType)):
    class Config:
        from_attributes = True


class FriendPostSchema(BaseModel):
    friend_id: int
    type: str | None = None


class FriendSchema(sqlalchemy_to_pydantic(Friend)):
    class Config:
        from_attributes = True


class FriendWithFriendSchema(FriendSchema):
    type: str | None = None
    friend: UserWithRoleSchema


class FavouritePostSchema(BaseModel):
    product_item_id: int


class BasketPostSchema(BaseModel):
    product_item_id: int
    count: int


class EventPostSchema(BaseModel):
    user_id: int | None = None
    description: str | None = None
    time: datetime
    details: dict | None = None


class BasketSchema(sqlalchemy_to_pydantic(Basket)):
    class Config:
        from_attributes = True


class FavouriteSchema(sqlalchemy_to_pydantic(Favourite)):
    class Config:
        from_attributes = True

class ProductItemRelative(ProductItemSchema):
    product: ProductSchemaForGet

class FavouriteWithProductItemSchema(FavouriteSchema):
    product_item: ProductItemRelative


class GetBasketSchema(BasketSchema):
    product_item: ProductItemWithProduct | None = None


class GetFavouriteSchema(FavouriteSchema):
    product_item: ProductItemWithProduct | None = None


class EventSchema(sqlalchemy_to_pydantic(Event)):
    class Config:
        from_attributes = True


class HistorySchema(sqlalchemy_to_pydantic(PurshaseHistory)):
    product_item: ProductItemSchema | None = None

    class Config:
        from_attributes = True


class UserRecommendSchema(UserDBSchema):
    favourites: list[FavouriteWithProductItemSchema] | None = None


class RecommendFriendSchema(FriendSchema):
    type: str | None = None
    friend: UserRecommendSchema | None = None
