from src.database.models import *
from src.mappers import SimpleMapper
from src.user.schemas import *


class RoleMapper(SimpleMapper[RoleSchema]):
    def __init__(self):
        super().__init__(RoleSchema)


class UserDBMapper(SimpleMapper[UserDBSchema]):
    def __init__(self):
        super().__init__(UserDBSchema)
