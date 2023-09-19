import difflib
import re

from src.schemas import ExecuteQueryData, FindQueryData
from src.config import TypesenseCon, TypesenseCon
from src.consts import *


class AIService:
    async def find_endpoints(self, q: FindQueryData, limit: int):
        search_parameters = {
            "q": q.text,
            "query_by": "description,embedding",
            "exclude_fields": "embedding",
            "prefix": "false",
            "per_page": limit,
        }
        res = TypesenseCon.collections[NAME_SCEMA_ENDPOINT].documents.search(
            search_parameters
        )
        result = []
        if res["found"] > 0:
            for r in res["hits"]:
                result.append(r["document"])
        return result

    async def parse_query(self, q: ExecuteQueryData):
        search_parameters = {
            "q": q.text,
            "query_by": "description",
            "prefix": "false",
            "per_page": 1,
        }
        search = TypesenseCon.collections[NAME_SCEMA_ENDPOINT].documents.search(
            search_parameters
        )
        for res in search["hits"]:
            description = res["document"]["description"]
            matcher = difflib.SequenceMatcher(None, description, q.method)
            similarity = matcher.ratio()
            if similarity >= 0.95:
                highlight = res["highlight"]
                for k, v in highlight.items():
                    for t in v["matched_tokens"]:
                        q.text = q.text.replace(t, "")
        counts = re.findall(r"\d+", q.text)
        q.text = re.sub(r"\d+", "", q.text)
        documents = await self.find_products(q)
        return {"details": {"counts": counts}, "product": documents}

    async def find_products(self, q: FindQueryData, limit: int):
        search_parameters = {
            "q": q.text,
            "query_by": "description,name,embedding",
            "exclude_fields": "embedding",
            "prefix": "false",
            "per_page": limit,
        }
        res = TypesenseCon.collections[NAME_SCEMA_PRODUCT].documents.search(
            search_parameters
        )
        result = []
        if res["found"] > 0:
            for r in res["hits"]:
                result.append(r["document"])
        return result
