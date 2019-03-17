FROM postgres:11

RUN apt update && \
    apt install -y --no-install-recommends \
        postgis=2.5.1+dfsg-1.pgdg90+1 \
        postgresql-11-postgis-2.5=2.5.1+dfsg-1.pgdg90+1 \
        postgresql-11-postgis-2.5-scripts=2.5.1+dfsg-1.pgdg90+1 && \
    rm -rf /var/lib/apt/lists/*
