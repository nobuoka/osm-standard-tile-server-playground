FROM ubuntu:18.04

# renderd and Mapnik (renderd depends on libmapnik3.0)
RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:osmadmins/ppa && \
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
    # Shapefile download (shapeindex needed)
    scripts/get-shapefiles.py

# Fonts
RUN apt update && \
    apt install -y --no-install-recommends \
        fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted fonts-hanazono ttf-unifont && \
    rm -rf /var/lib/apt/lists/*

RUN cd /home/renderaccount/src/openstreetmap-carto && \
    sed -i /'dbname: "gis"'/a'\    host: "%POSTGRES_HOST%"\n    user: "%POSTGRES_USER%"\n    password: "%POSTGRES_PASSWORD%"' project.mml && \
    sed -i s/'dbname: "gis"'/'dbname: "%POSTGRES_DB%"'/ project.mml && \
    carto project.mml > mapnik.xml.template

ADD ./renderd.conf /etc/renderd.conf

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
