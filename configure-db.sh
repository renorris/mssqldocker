#!/bin/bash

# Wait for MSSQL server to start
export STATUS=1
i=0

while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
    i=$i+1
    /opt/mssql-tools18/bin/sqlcmd -t 1 -U sa -P $SA_PASSWORD -C -Q "select 1" >> /dev/null
    STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
    echo "Error: MSSQL SERVER took more than thirty seconds to start up."
    exit 1
fi

echo "[configure-db.sh] Bootstrapping MSSQL configuration" | tee -a ./config.log

# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -d master -i setup.sql

echo "[configure-db.sh] Bootstrap complete" | tee -a ./config.log
echo "[configure-db.sh] MSSQL HEALTHY" | tee -a ./config.log
