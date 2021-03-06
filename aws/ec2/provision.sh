export DEBIAN_FRONTEND=noninteractive

apt update
apt install -y --no-install-recommends software-properties-common

add-apt-repository -y ppa:osmadmins/ppa
apt update

# === web server ===
# Apache and mod_tile
apt install -y --no-install-recommends apache2 libapache2-mod-tile
# Config files (These are automatically created)
#   /etc/apache2/mods-available/tile.load : for loading mod_tile module
#   /etc/apache2/sites-available/tileserver_site.conf : for providing OSM tile support

# === renderer ===
# user account for rendering
sudo useradd -m renderaccount -p renderaccount

# renderd and Mapnik (renderd depends on libmapnik3.0)
apt install -y --no-install-recommends renderd

# Stylesheet configuration
# mapnik-utils is needed for shapeindex command
apt install -y --no-install-recommends mapnik-utils git-core npm nodejs ca-certificates
npm install -g carto
mkdir -p /home/renderaccount/src
cd /home/renderaccount/src
git clone https://github.com/gravitystorm/openstreetmap-carto.git
cd openstreetmap-carto
#sed -i /'dbname: "gis"'/a'\    host: "map-database"\n    user: "renderaccount"\n    password: "renderaccount"' project.mml
carto project.mml > mapnik.xml
# Shapefile download (shapeindex needed)
scripts/get-shapefiles.py

# Fonts
apt install -y --no-install-recommends \
        fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted ttf-unifont

# permission
sudo mkdir -p /var/lib/mod_tile
sudo chown renderaccount /var/lib/mod_tile

sudo mkdir -p /var/run/renderd
sudo chown renderaccount /var/run/renderd

# === osm2pgsql ===
apt install -y --no-install-recommends \
        osm2pgsql \
        git-core wget

# === database ===
apt install -y --no-install-recommends \
        postgresql-10 \
        postgresql-10-postgis-2.4 \
        postgresql-10-postgis-2.4-scripts

sudo -u postgres createuser renderaccount
sudo -u postgres createdb -E UTF8 -O renderaccount gis
