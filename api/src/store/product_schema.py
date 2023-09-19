from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from src.database.models.store.product_feedback import ProductFeedback
from src.user.schemas import UserWithRoleSchema


class ProductFeedbackSchema(sqlalchemy_to_pydantic(ProductFeedback)):
    like_count: int
    is_like: bool = False
    user: UserWithRoleSchema | None = None

    class Config:
        from_attributes = True
