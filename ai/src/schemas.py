from pydantic import BaseModel


class FindQueryData(BaseModel):
    text: str


class ExecuteQueryData(FindQueryData):
    method: str
