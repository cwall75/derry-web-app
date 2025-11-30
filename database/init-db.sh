#!/bin/bash
# Don't use set -e here as we need to handle errors gracefully

echo "========================================="
echo "Derry Missing Persons Database Init"
echo "========================================="

BACKUP_FILE="/docker-entrypoint-initdb.d/backup/derry_missing_backup.sql"
SCHEMA_FILE="/docker-entrypoint-initdb.d/01-init.sql"

# Wait for PostgreSQL to be ready
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

echo "PostgreSQL is ready!"

# Check if database already has data (table might not exist yet, so suppress errors)
VICTIM_COUNT=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT COUNT(*) FROM victims" 2>/dev/null || echo "0")

# If the query failed due to table not existing, treat as empty
if [ -z "$VICTIM_COUNT" ] || [ "$VICTIM_COUNT" = "" ]; then
    VICTIM_COUNT="0"
fi

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
    if psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$BACKUP_FILE"; then
        # Verify restoration
        VICTIM_COUNT=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT COUNT(*) FROM victims" 2>/dev/null || echo "0")
        echo "Restoration complete! Total victims: $VICTIM_COUNT"
    else
        echo "ERROR: Failed to restore from backup file!"
        exit 1
    fi

elif [ -f "$SCHEMA_FILE" ]; then
    echo "Backup file not found. Using schema file: $SCHEMA_FILE"
    echo "Creating database schema..."

    # Create schema
    if psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$SCHEMA_FILE"; then
        echo "Schema created successfully!"
        echo "Note: Database has no victim data. You may need to run the seed service."
    else
        echo "ERROR: Failed to create schema from schema file!"
        exit 1
    fi

else
    echo "ERROR: Neither backup file nor schema file found!"
    exit 1
fi

echo "========================================="
echo "Database initialization complete!"
echo "========================================="
