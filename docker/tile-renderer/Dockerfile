FROM ubuntu:18.04

# renderd and Mapnik (renderd depends on libmapnik3.0)
RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:osmadmins/ppa && \
    apt update && \
    apt install -y --no-install-recommends renderd && \
    rm -rf /var/lib/apt/lists/*

# Stylesheet configuration
RUN apt update && \
    # mapnik-utils is needed for shapeindex command
    apt install -y --no-install-recommends mapnik-utils git-core npm nodejs ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g carto && \
    mkdir -p /home/renderaccount/src && \
    cd /home/renderaccount/src && \
    git clone https://github.com/gravitystorm/openstreetmap-carto.git && \
    cd openstreetmap-carto && \
    sed -i /'dbname: "gis"'/a'\    host: "map-database"\n    user: "renderaccount"\n    password: "renderaccount"' project.mml && \
    carto project.mml > mapnik.xml && \
    # Shapefile download (shapeindex needed)
    scripts/get-shapefiles.py

# Fonts
RUN apt update && \
    apt install -y --no-install-recommends \
        fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted ttf-unifont && \
    rm -rf /var/lib/apt/lists/*
