# https://switch2osm.org/manually-building-a-tile-server-18-04-lts/

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y libboost-all-dev git-core tar unzip wget bzip2 \
        build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev libpq-dev \
        libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler \
        libfreetype6-dev libtiff5-dev libicu-dev libgdal-dev libcairo-dev \
        libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont \
        lua5.1 liblua5.1-dev libgeotiff-epsg curl

# Mapnik
RUN apt install -y autoconf apache2-dev libtool libxml2-dev libbz2-dev libgeos-dev \
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

# osm2pgsql
RUN cd /usr/src && \
    git clone git://github.com/openstreetmap/osm2pgsql.git && \
    cd osm2pgsql && \
    apt install -y make cmake g++ libboost-dev libboost-system-dev libboost-filesystem-dev \
        libexpat1-dev zlib1g-dev libbz2-dev libpq-dev libgeos-dev libgeos++-dev \
        libproj-dev lua5.2 liblua5.2-dev && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install

# Stylesheet configuration
RUN mkdir -p /home/renderaccount/src && \
    cd /home/renderaccount/src && \
    git clone git://github.com/gravitystorm/openstreetmap-carto.git && \
    cd openstreetmap-carto && \
    apt install -y npm nodejs && \
    npm install -g carto && \
    sed -i /'dbname: "gis"'/a'\    host: "map-database"\n    user: "renderaccount"\n    password: "renderaccount"' project.mml && \
    carto project.mml > mapnik.xml && \
        # mapnik.xml is referenced from /usr/local/etc/renderd.conf
    # Shapefile download
    scripts/get-shapefiles.py

# Configuring Apache
RUN echo "LoadModule tile_module /usr/lib/apache2/modules/mod_tile.so" \
        > /etc/apache2/conf-available/mod_tile.conf && \
    a2enconf mod_tile && \
    sed -i /'ServerAdmin'/a'\\n\tLoadTileConfigFile /usr/local/etc/renderd.conf\n\tModTileRenderdSocketName /var/run/renderd/renderd.sock\n\tModTileRequestTimeout 0\n\tModTileMissingRequestTimeout 30\n' \
        /etc/apache2/sites-available/000-default.conf

# Fonts
RUN apt install -y fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted ttf-unifont
