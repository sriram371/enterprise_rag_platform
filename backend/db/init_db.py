from backend.db.postgres import execute_query
from loguru import logger


def enable_pgvector():
    try:
        execute_query(
            "CREATE EXTENSION IF NOT EXISTS vector;",
            commit=True
        )
        logger.info("pgvector extension enabled successfully")

    except Exception as e:
        logger.error(f"Error enabling pgvector: {e}")
        raise e


def run_schema():
    try:
        with open("backend/db/schema.sql", "r") as file:
            schema_sql = file.read()

        execute_query(
            schema_sql,
            commit=True
        )

        logger.info("Database schema initialized successfully")

    except Exception as e:
        logger.error(f"Error initializing schema: {e}")
        raise e


if __name__ == "__main__":

    logger.info("Initializing database...")

    enable_pgvector()

    run_schema()

    logger.info("Database initialization complete")