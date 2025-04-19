#!/bin/bash

# Check required environment variables
required_vars=("ACCEPT_EULA" "SA_PASSWORD" "MSSQL_DB" "MSSQL_USER" "MSSQL_PASSWORD")
missing=()
for var in "${required_vars[@]}"; do
    if ! declare -p "$var" &> /dev/null; then
        missing+=("$var")
    fi
done
if [ ${#missing[@]} -gt 0 ]; then
    echo "Error: The following required environment variables are not set:"
    for m in "${missing[@]}"; do
        echo "  $m"
    done
    exit 1
fi

# Run configuration in background
/usr/config/configure-db.sh &

# Start SQL Server as main process
exec /opt/mssql/bin/sqlservr
