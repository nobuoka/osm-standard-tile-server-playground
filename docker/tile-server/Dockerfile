# https://switch2osm.org/manually-building-a-tile-server-18-04-lts/

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev \
        libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler \
        libfreetype6-dev libtiff5-dev libicu-dev libgdal-dev libcairo-dev \
        libcairomm-1.0-dev apache2 apache2-dev libagg-dev ttf-unifont \
        libgeotiff-epsg \
        # Tools
        git-core tar unzip bzip2 wget curl ca-certificates

# Mapnik
RUN apt install -y --no-install-recommends \
        autoconf apache2-dev libtool libxml2-dev libbz2-dev libgeos-dev \
        libgeos++-dev libproj-dev gdal-bin libmapnik-dev mapnik-utils python-mapnik

# mod_tile
RUN cd /usr/src && \
    git clone -b switch2osm git://github.com/SomeoneElseOSM/mod_tile.git && \
    cd mod_tile && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    make install-mod_tile && \
    ldconfig

# Configuring Apache
RUN echo "LoadModule tile_module /usr/lib/apache2/modules/mod_tile.so" \
        > /etc/apache2/conf-available/mod_tile.conf && \
    a2enconf mod_tile && \
    sed -i /'ServerAdmin'/a'\\n\tLoadTileConfigFile /usr/local/etc/renderd.conf\n\tModTileRenderdSocketAddr tile-renderer 7654\n\tModTileRequestTimeout 0\n\tModTileMissingRequestTimeout 30\n' \
        /etc/apache2/sites-available/000-default.conf
