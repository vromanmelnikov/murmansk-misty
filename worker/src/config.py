from pydantic_settings import BaseSettings


# environment
class Settings(BaseSettings):
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_DB: str
    HOST: str
    PORT: str
    
    TOKEN_TYPE:str
    API_URL: str
    ACCESS_TOKEN: str

    class Config:
        env_file = ".env"


settings = Settings()
