sudo apt update
sudo apt install -y --no-install-recommends software-properties-common

sudo add-apt-repository -y ppa:osmadmins/ppa
sudo apt update

# === web server ===
sudo apt install -y --no-install-recommends \
        # Apache and mod_tile
        apache2 libapache2-mod-tile \
                # Config files (These are automatically created)
                #   /etc/apache2/mods-available/tile.load : for loading mod_tile module
                #   /etc/apache2/sites-available/tileserver_site.conf : for providing OSM tile support
        # renderd and Mapnik (renderd depends on libmapnik3.0)
        renderd \
        # Packages for osm-carto
        # mapnik-utils is needed for shapeindex command
        mapnik-utils git-core npm nodejs ca-certificates \
        # Fonts
        fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted ttf-unifont \
        # osm2pgsql
        osm2pgsql \
        # database
        postgresql-10 \
        postgresql-10-postgis-2.4 \
        postgresql-10-postgis-2.4-scripts
