# https://wiki.openstreetmap.org/wiki/Osm2pgsql#For_Debian_or_Ubuntu

FROM ubuntu:18.04

# osm2pgsql
RUN apt update && \
    apt install -y --no-install-recommends \
        osm2pgsql \
        # tools
        git-core wget && \
    rm -rf /var/lib/apt/lists/* && \
    cd / && \
    git clone git://github.com/gravitystorm/openstreetmap-carto.git
