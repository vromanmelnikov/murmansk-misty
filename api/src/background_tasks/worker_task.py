import requests
from src.config import CeleryConnection, settings

TIME_INTERVAL = 60*3


@CeleryConnection.on_after_configure.connect
def setup_periodic_tasks(sender, **kwargs):
    sender.add_periodic_task(TIME_INTERVAL, do_tasks.s(), name="handle tasks")


@CeleryConnection.task()
def do_tasks():
    requests.get(f"{settings.WORKER_URL}/tasks/handle")
