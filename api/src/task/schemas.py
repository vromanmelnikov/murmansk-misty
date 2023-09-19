from datetime import date, datetime, timedelta
from pydantic import BaseModel
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from src.database.models import *


class PeriodSchema(BaseModel):
    unit: str
    value: int
    count: int | None = None


class UnitIntervalDBSchema(sqlalchemy_to_pydantic(UnitInterval)):
    details: dict | None = None

    class Config:
        from_attributes = True


class TaskDBSchema(sqlalchemy_to_pydantic(Task)):
    last_date_execute: datetime | None = None
    date_execute: datetime | None = None
    duration: str | timedelta | None = None

    class Config:
        from_attributes = True


class TaskCreateSchema(BaseModel):
    name: str
    date_execute: datetime | None = None
    period: PeriodSchema | None = None
    path: str
    is_active: bool = True
    details: dict | None = None


class TaskUpdateSchema(TaskCreateSchema):
    id: int
