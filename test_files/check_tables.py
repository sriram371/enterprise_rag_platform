from backend.db.postgres import execute_query

tables = execute_query("""
SELECT table_name
FROM information_schema.tables
WHERE table_schema='public';
""")

print(tables)