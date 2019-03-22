FROM postgres:11

RUN apt update && \
    apt install -y --no-install-recommends \
        postgresql-11-postgis-2.5 \
        postgresql-11-postgis-2.5-scripts && \
    rm -rf /var/lib/apt/lists/*
