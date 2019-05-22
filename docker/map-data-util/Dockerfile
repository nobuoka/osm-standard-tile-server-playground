# https://wiki.openstreetmap.org/wiki/Osm2pgsql#For_Debian_or_Ubuntu

FROM ubuntu:18.04

# osm2pgsql and tools
RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:osmadmins/ppa && \
    apt update && \
    apt install -y --no-install-recommends \
        osm2pgsql git-core wget postgresql-client && \
    rm -rf /var/lib/apt/lists/*

RUN cd / && \
    git clone git://github.com/gravitystorm/openstreetmap-carto.git

COPY ./init-db /usr/local/bin/init-db
RUN chmod +x /usr/local/bin/init-db

ENTRYPOINT ["bash"]
