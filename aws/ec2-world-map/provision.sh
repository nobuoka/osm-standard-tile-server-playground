set -eu

source_dir_url=${OSM_AWS_EC2_URL:-"https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/master/aws/ec2-world-map"}
resources_url="${source_dir_url}/resources"

mkdir -p resources
curl "${resources_url}/install-apt-packages.sh" > resources/install-apt-packages.sh
curl "${resources_url}/install-osm-carto.sh" > resources/install-osm-carto.sh
curl "${resources_url}/setup-tools.sh" > resources/setup-tools.sh
curl "${resources_url}/init-db.sql" > resources/init-db.sql
curl "${resources_url}/renderd.conf" > resources/renderd.conf
curl "${resources_url}/tileserver_renderd.conf" > resources/tileserver_renderd.conf
curl "${resources_url}/tileserver_site.conf" > resources/tileserver_site.conf

# === renderer ===
# user account for rendering
#sudo useradd -m renderaccount -p renderaccount

source ./resources/install-apt-packages.sh
source ./resources/install-osm-carto.sh
source ./setup-tools.sh
