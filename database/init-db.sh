#!/bin/bash
set -e

echo "========================================="
echo "Derry Missing Persons Database Init"
echo "========================================="

BACKUP_FILE="/docker-entrypoint-initdb.d/derry_missing_backup.sql"
SCHEMA_FILE="/docker-entrypoint-initdb.d/init.sql"

# Wait for PostgreSQL to be ready
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

echo "PostgreSQL is ready!"

# Check if database already has data
VICTIM_COUNT=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT COUNT(*) FROM victims" 2>/dev/null || echo "0")

if [ "$VICTIM_COUNT" != "0" ]; then
    echo "Database already contains $VICTIM_COUNT victims. Skipping initialization."
    exit 0
fi

echo "Database is empty. Initializing..."

# Check if backup file exists
if [ -f "$BACKUP_FILE" ]; then
    echo "Found backup file: $BACKUP_FILE"
    echo "Restoring database from backup..."

    # Restore from backup
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$BACKUP_FILE"

    # Verify restoration
    VICTIM_COUNT=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT COUNT(*) FROM victims")
    echo "Restoration complete! Total victims: $VICTIM_COUNT"

elif [ -f "$SCHEMA_FILE" ]; then
    echo "Backup file not found. Using schema file: $SCHEMA_FILE"
    echo "Creating database schema..."

    # Create schema
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$SCHEMA_FILE"

    echo "Schema created successfully!"
    echo "Note: Database has no victim data. You may need to run the seed service."

else
    echo "ERROR: Neither backup file nor schema file found!"
    exit 1
fi

echo "========================================="
echo "Database initialization complete!"
echo "========================================="
