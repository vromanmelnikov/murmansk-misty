FROM python:3.10
RUN mkdir /worker
WORKDIR /worker
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt
RUN python -m pip install -U pydantic pydantic-settings pydantic[email]
COPY . .
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "6104"]
EXPOSE 6102