# Stylesheet configuration
# mapnik-utils is needed for shapeindex command
sudo apt install -y --no-install-recommends mapnik-utils git-core npm nodejs ca-certificates
sudo npm install -g carto

cd /home/ubuntu/osm
git clone https://github.com/gravitystorm/openstreetmap-carto.git
cd openstreetmap-carto
#sed -i /'dbname: "gis"'/a'\    host: "map-database"\n    user: "renderaccount"\n    password: "renderaccount"' project.mml
carto project.mml > mapnik.xml
# Shapefile download (shapeindex needed)
scripts/get-shapefiles.py
