# mssqldocker

This project builds a Docker image based on the official Microsoft SQL Server 2022 image (`mcr.microsoft.com/mssql/server:2022-latest`) and configures it with a specified database and user. It simplifies setting up a SQL Server instance for development and testing environments using Docker.

## Features
- Automated setup of a SQL Server 2022 instance with a custom database and admin user.
- Docker image available on GitHub Container Registry (ghcr.io).
- Idempotent SQL scripts for database and user creation.

## How to Run

### Docker Image

```bash
docker run \
-e ACCEPT_EULA=Y \
-e SA_PASSWORD=YourStrong@Passw0rd \
-e MSSQL_DB=myDatabase \
-e MSSQL_USER=myUser \
-e MSSQL_PASSWORD=Another@Passw0rd \
-p 1433:1433 \
ghcr.io/rnorris/mssqldocker:latest
```
- Ensure the `SA_PASSWORD` and `MSSQL_PASSWORD` are at least 8 characters long, containing uppercase, lowercase, digits, and symbols.

### Connecting to the Database
To connect to the SQL Server instance running in the container:
```bash
docker exec -it <container_name> /opt/mssql-tools18/bin/sqlcmd -No -S localhost -U sa -P <SA_PASSWORD>
```

## Environment Variables
The following environment variables are required:

| Variable          | Description                                      | Required |
|-------------------|--------------------------------------------------|----------|
| `ACCEPT_EULA`     | Set to "Y" to accept the SQL Server license      | Yes      |
| `SA_PASSWORD`     | Password for the SA account (strong password)    | Yes      |
| `MSSQL_DB`        | Name of the database to create                   | Yes      |
| `MSSQL_USER`      | Username for the new user with admin privileges  | Yes      |
| `MSSQL_PASSWORD`  | Password for the new user (strong password)      | Yes      |

**Note:** Passwords must be at least 8 characters long and include uppercase, lowercase, digits, and symbols, as per SQL Server requirements.

## Contributing
Contributions are welcome! Please submit issues or pull requests to the [GitHub repository](https://github.com/mcmoe/mssqldocker).

## Acknowledgments
- Original work by Travis Wright, extensively modified by Morgan Kobeissi.
- Built upon the official Microsoft SQL Server Docker image.
