FROM python:3.10
RUN mkdir /ai
WORKDIR /ai
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt
RUN python -m pip install -U pydantic pydantic-settings
COPY . .
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "6101"]
EXPOSE 6101