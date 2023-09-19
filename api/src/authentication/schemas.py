from pydantic import BaseModel, EmailStr, Field, HttpUrl
from pydantic_extra_types.phone_numbers import PhoneNumber
from pydantic_extra_types.coordinate import Longitude, Latitude
from datetime import datetime
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from src.database.models import *
from src.authentication.constants import TOKEN_TYPE_BEARER
from src.mappers import BaseMapper


class TokenSchema(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str | None = TOKEN_TYPE_BEARER

    @staticmethod
    def Of(access_token: str, refresh_token: str, token_type: str = TOKEN_TYPE_BEARER):
        return TokenSchema(
            access_token=access_token,
            refresh_token=refresh_token,
            token_type=token_type,
        )


class RecoverPasswordSchema(BaseModel):
    email: EmailStr


class ResetPasswordSchema(BaseModel):
    code: str = Field(min_length=16)
    password: str = Field(min_length=8)


class TokenDataSchema(BaseModel):
    id: int
    role_id: int | None = None

    @staticmethod
    def Of(id: int, role_id: int):
        return TokenDataSchema(id=id, role_id=role_id)


class UserLoginSchema(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8)


# class UserRegisterSchema(UserLoginSchema):
#     firstname: str = Field(min_length=1, max_length=100)
#     lastname: str = Field(min_length=1, max_length=100)
#     patronymic: str = Field(min_length=1, max_length=100)


class TypeSelectMapperSchema:
    def __init__(self, mapper: BaseMapper, repository: str):
        self.repository = repository
        self.mapper = mapper
