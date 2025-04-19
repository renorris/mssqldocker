FROM mcr.microsoft.com/mssql/server:2022-CU18-ubuntu-22.04

USER root

# Copy config into container
RUN mkdir -p /usr/config

WORKDIR /usr/config

COPY . /usr/config

RUN chmod +x /usr/config/entrypoint.sh && \
    chmod +x /usr/config/configure-db.sh && \
    chown -R mssql:mssql /usr/config

USER mssql

ENTRYPOINT ["./entrypoint.sh"]

HEALTHCHECK --interval=15s CMD /opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -Q "select 1" && grep -q "MSSQL HEALTHY" ./config.log
