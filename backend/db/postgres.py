"""
Production-grade PostgreSQL connection manager

Used by:
- Retrieval layer
- Memory layer
- Evaluation layer
- Logging layer
- Authentication layer
"""

import os
import psycopg2
import psycopg2.extras
from psycopg2.pool import SimpleConnectionPool
from contextlib import contextmanager
from dotenv import load_dotenv
from loguru import logger


# Load environment variables
load_dotenv()


# ============================================================
# DATABASE CONFIGURATION
# ============================================================

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", 5432)
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


# ============================================================
# CONNECTION POOL
# ============================================================

try:

    connection_pool = SimpleConnectionPool(
        minconn=1,
        maxconn=10,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        cursor_factory=psycopg2.extras.RealDictCursor
    )

    logger.info("PostgreSQL connection pool created successfully")

except Exception as e:

    logger.error(f"Error creating connection pool: {e}")
    raise e


# ============================================================
# CONNECTION MANAGER
# ============================================================

@contextmanager
def get_db_connection():
    """
    Provides a database connection from pool
    Ensures safe release back to pool
    """

    conn = None

    try:

        conn = connection_pool.getconn()

        yield conn

    except Exception as e:

        logger.error(f"Database connection error: {e}")
        raise e

    finally:

        if conn:
            connection_pool.putconn(conn)


# ============================================================
# CURSOR MANAGER
# ============================================================

@contextmanager
def get_db_cursor(commit: bool = False):
    """
    Provides database cursor with automatic commit and cleanup

    Args:
        commit: whether to commit transaction
    """

    with get_db_connection() as conn:

        cursor = conn.cursor()

        try:

            yield cursor

            if commit:
                conn.commit()

        except Exception as e:

            conn.rollback()
            logger.error(f"Database cursor error: {e}")
            raise e

        finally:

            cursor.close()


# ============================================================
# HEALTH CHECK
# ============================================================

def check_db_health():
    """
    Check database connectivity
    Used in monitoring and startup validation
    """

    try:

        with get_db_cursor() as cursor:

            cursor.execute("SELECT 1")

            result = cursor.fetchone()

            if result:

                logger.info("Database health check passed")
                return True

    except Exception as e:

        logger.error(f"Database health check failed: {e}")
        return False


# ============================================================
# EXECUTE QUERY HELPER
# ============================================================

def execute_query(query: str, params=None, commit: bool = False):
    """
    Execute SQL query safely

    Args:
        query: SQL query string
        params: query parameters
        commit: whether to commit transaction

    Returns:
        query result if SELECT, else None
    """

    with get_db_cursor(commit=commit) as cursor:

        cursor.execute(query, params)

        if cursor.description:

            return cursor.fetchall()

        return None
