from copy import copy
import requests
from typesense import Client

from src.consts import NAME_SCEMA_ENDPOINT, NAME_SCEMA_PRODUCT
from src.config import EndpointsSchema, ProductsSchema, settings


def parse_openapi(res):
    enpoints = []
    paths = res["paths"]
    for path, value in paths.items():
        for method, method_value in value.items():
            enpoints.append(
                {
                    "path": path,
                    "summary": method_value.get("summary", ""),
                    "description": method_value.get("description", ""),
                    "type_method": method,
                }
            )
    return enpoints


def load_products():
    is_exit = False
    all_products = []
    i = 0
    while not is_exit:
        res = requests.get(f"{settings.API_URL}/stores/products/all?offset={i}").json()
        if res.get("count", None) is None:
            break
        for item in res["items"]:
            it = copy(item)
            it["product_id"] = item["id"]
            del it["id"]
            all_products.append(it)
        i += 1
    return all_products


def methods_load(client: Client):
    try:
        client.collections[NAME_SCEMA_ENDPOINT].delete()
    except Exception as e:
        pass
    client.collections.create(EndpointsSchema)
    res = requests.get(f"{settings.API_URL}/openapi.json").json()
    documents = parse_openapi(res)
    client.collections[NAME_SCEMA_ENDPOINT].documents.import_(documents)
    return True


def products_load(client: Client):
    try:
        client.collections[NAME_SCEMA_PRODUCT].delete()
    except Exception as e:
        pass
    client.collections.create(ProductsSchema)
    documents = load_products()
    client.collections[NAME_SCEMA_PRODUCT].documents.import_(documents)
    return True
