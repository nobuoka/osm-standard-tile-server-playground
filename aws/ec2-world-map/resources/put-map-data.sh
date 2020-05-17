carto_dir=${CARTO_PATH:-"/home/ubuntu/osm/openstreetmap-carto"}
map_url=${MAP_URL:-"https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf"}

cache_file="/tmp/osm_nodes.cache"

cd ..
mkdir -p mapdata
cd mapdata

wget $map_url -O map.osm.pbf

# * -C (cache size): should be around 80% of the free RAM (GB)
# * --number-processes: should be equal to number of CPU cores
sudo -u www-data osm2pgsql -d gis \
  --create --slim -G --hstore --tag-transform-script $carto_dir/openstreetmap-carto.lua \
  -C 20000 --number-processes 4 -S $carto_dir/openstreetmap-carto.style \
  --flat-nodes $cache_file \
  --cache-strategy dense \
  ./map.osm.pbf

sudo -u www-data rm $cache_file

# Create indexes
wget https://raw.githubusercontent.com/gravitystorm/openstreetmap-carto/master/indexes.sql
sudo -u www-data psql -d gis -f indexes.sql

sudo service renderd restart
