"""
Central configuration manager

All services should import configuration from this module.
"""

import os
from dotenv import load_dotenv
from pydantic import BaseModel
from loguru import logger


# Load environment variables
load_dotenv()


class DatabaseConfig(BaseModel):
    host: str
    port: int
    name: str
    user: str
    password: str


class BedrockConfig(BaseModel):
    region: str
    embedding_model: str
    llm_model: str


class AppConfig(BaseModel):
    environment: str
    debug: bool


class Settings:

    def __init__(self):

        self.database = DatabaseConfig(
            host=os.getenv("DB_HOST"),
            port=int(os.getenv("DB_PORT", 5432)),
            name=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )

        self.bedrock = BedrockConfig(
            region=os.getenv("AWS_REGION", "us-east-1"),
            embedding_model=os.getenv(
                "BEDROCK_EMBEDDING_MODEL",
                "amazon.titan-embed-text-v1"
            ),
            llm_model=os.getenv(
                "BEDROCK_LLM_MODEL",
                "anthropic.claude-3-haiku-20240307-v1:0"
            )
        )

        self.app = AppConfig(
            environment=os.getenv("ENVIRONMENT", "development"),
            debug=os.getenv("DEBUG", "false").lower() == "true"
        )

        logger.info("Configuration loaded successfully")


# Global config instance
settings = Settings()