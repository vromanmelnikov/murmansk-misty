from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from src.database.models import *
from src.tag.schemas import ProductTagLinkSchema, StoreTagLinkSchema


class StorePostSchema(BaseModel):
    name: str = Field(min_length=1, max_length=255)
    img: str | None = None
    site: str | None = None
    coords: dict | None = None
    address: str | None = None
    description: str | None = None
    is_active: bool | None = True
    details: dict | None = None


class StoreUpdateSchema(StorePostSchema):
    id: int


class ProductSchemaBasic(BaseModel):
    name: str = Field(min_length=1, max_length=255)
    is_service: bool
    description: str | None = None
    preview_img: str | None = None
    details: dict | None = None


class ProductPostSchema(ProductSchemaBasic):
    store_id: int


class ProductItemSchema(sqlalchemy_to_pydantic(ProductItem)):
    class Config:
        from_attributes = True


class GetProductSchema(sqlalchemy_to_pydantic(Product)):
    count_items: int
    price_info: dict
    rating: int | None = None

    class Config:
        from_attributes = True


class ProductWithProductItems(GetProductSchema):
    product_items: list[ProductItemSchema]




class ProductUpdateSchema(ProductSchemaBasic):
    id: int


class ProductItemSchemaBasic(BaseModel):
    price: int
    name: str
    count: int | None = 0
    details: dict | None = None


class ProductItemPostSchema(ProductItemSchemaBasic):
    product_id: int


class ProductItemUpdateSchema(ProductItemSchemaBasic):
    id: int


class BuyProductItemSchema(BaseModel):
    count: int = Field(ge=1)
    product_id: int
    user_id: int | None = None


class StoreGetUserSchema(sqlalchemy_to_pydantic(Store)):
    description: str | None = None
    img: str | None = None
    address: str | None = None
    coordinates: dict | None = None
    site: str | None = None
    details: dict | None = None

    class Config:
        from_attributes = True


class StoreSchema(sqlalchemy_to_pydantic(Store)):
    description: str | None = None
    img: str | None = None
    address: str | None = None
    coordinates: dict | None = None
    site: str | None = None
    details: dict | None = None

    rating: int | None = None

    class Config:
        from_attributes = True


class StoreWithTags(StoreSchema):
    store_tag_links: list[StoreTagLinkSchema] = []


class ProductSchemaForGet(sqlalchemy_to_pydantic(Product)):
    description: str | None = None
    preview_img: str | None = None
    details: dict | None = None

    class Config:
        from_attributes = True


class ProductWithTags(ProductSchemaForGet):
    product_tag_links: list[ProductTagLinkSchema] = []
    count_items: int | None = None
    price_info: dict | None = None
    rating: int | None = None


class ProductSchema(sqlalchemy_to_pydantic(Product)):
    description: str | None = None
    preview_img: str | None = None
    details: dict | None = None

    class Config:
        from_attributes = True


class ProductItemWithProduct(ProductItemSchema):
    product: ProductSchemaForGet | None = None


class CharacteristicSchema(sqlalchemy_to_pydantic(Characteristic)):
    class Config:
        from_attributes = True


class ProductFeedbackPostSchema(BaseModel):
    mark: int = Field(ge=1, le=5)
    product_id: int
    review: str | None = None


class LikePostSchema(BaseModel):
    product_feedback_id: int
