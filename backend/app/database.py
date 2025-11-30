"""Database connection and utilities"""
import os
import psycopg2
from psycopg2.extras import RealDictCursor
from contextlib import contextmanager
import time


def get_db_connection():
    """Create a database connection"""
    max_retries = 5
    retry_delay = 2

    for attempt in range(max_retries):
        try:
            conn = psycopg2.connect(
                host=os.getenv('DB_HOST', 'postgres'),
                port=os.getenv('DB_PORT', '5432'),
                database=os.getenv('DB_NAME', 'derry_missing'),
                user=os.getenv('DB_USER', 'derry_admin'),
                password=os.getenv('DB_PASSWORD', 'pennywise1958'),
                cursor_factory=RealDictCursor
            )
            return conn
        except psycopg2.OperationalError as e:
            if attempt < max_retries - 1:
                print(f"Database connection attempt {attempt + 1} failed. Retrying in {retry_delay}s...")
                time.sleep(retry_delay)
            else:
                raise Exception(f"Could not connect to database after {max_retries} attempts: {e}")


@contextmanager
def get_db_cursor():
    """Context manager for database operations"""
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        yield cursor
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cursor.close()
        conn.close()
