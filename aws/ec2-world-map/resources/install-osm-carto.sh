
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