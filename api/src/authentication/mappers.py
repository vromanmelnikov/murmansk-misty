from fastapi.security import OAuth2PasswordRequestForm
from src.authentication.schemas import *
from src.const import *
from src.mappers import SimpleMapper
from src.user.schemas import *


class UserLoginMapper:
    def create_from_input(self, form_data: OAuth2PasswordRequestForm):
        return UserLoginSchema(email=form_data.username, password=form_data.password)


class PasswordRecoveryMapper:
    def create_from_database(self, value: bytes):
        return value.decode("utf-8")


class UserMapper:
    def create_from_input(self, user: UserLoginSchema, role_id: int = ROLE_CUSTOMER):
        return User(email=user.email, hashed_password=user.password, role_id=role_id)
