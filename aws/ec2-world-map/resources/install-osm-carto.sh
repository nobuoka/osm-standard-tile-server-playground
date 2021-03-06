# Stylesheet configuration
# mapnik-utils is needed by shapeindex command
# python3-distutils is needed by scripts/get-shapefiles.py
sudo apt install -y --no-install-recommends mapnik-utils git-core npm nodejs ca-certificates python3-distutils
sudo npm install -g carto

cd /home/ubuntu/osm
git clone https://github.com/gravitystorm/openstreetmap-carto.git
cd openstreetmap-carto
#sed -i /'dbname: "gis"'/a'\    host: "map-database"\n    user: "renderaccount"\n    password: "renderaccount"' project.mml
carto project.mml > mapnik.xml
# Shapefile download (shapeindex needed)
scripts/get-shapefiles.py
