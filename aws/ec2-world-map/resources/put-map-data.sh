carto_dir=${CARTO_PATH:-"/home/ubuntu/osm/openstreetmap-carto"}
map_url=${MAP_URL:-"https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf"}

cd ..
mkdir mapdata
cd mapdata

wget $map_url -O map.osm.pbf

# http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf
# Planet
# wget https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf

sudo -u www-data osm2pgsql -d gis \
  --create --slim -G --hstore --tag-transform-script $carto_dir/openstreetmap-carto.lua \
  -C 2500 --number-processes 1 -S $carto_dir/openstreetmap-carto.style \
  --flat-nodes ./osm_nodes.cache \
  --cache-strategy dense \
  ./map.osm.pbf

# Create indexes
wget https://raw.githubusercontent.com/gravitystorm/openstreetmap-carto/master/indexes.sql
sudo -u www-data psql -d gis -f indexes.sql
