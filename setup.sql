-- Check if the database exists, and create it if it does not
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'$(MSSQL_DB)')
BEGIN
    CREATE DATABASE $(MSSQL_DB);
END
GO

-- Check if the login exists, and create it if it does not
IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = N'$(MSSQL_USER)')
BEGIN
    CREATE LOGIN $(MSSQL_USER) WITH PASSWORD = '$(MSSQL_PASSWORD)';
END
GO

-- Switch to the specified database
USE $(MSSQL_DB);
GO

-- Check if the user exists in the database, and create it if it does not
IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = N'$(MSSQL_USER)')
BEGIN
    CREATE USER $(MSSQL_USER) FOR LOGIN $(MSSQL_USER);
END
GO

-- Add the login to the sysadmin role (idempotent operation)
ALTER SERVER ROLE sysadmin ADD MEMBER [$(MSSQL_USER)];
GO