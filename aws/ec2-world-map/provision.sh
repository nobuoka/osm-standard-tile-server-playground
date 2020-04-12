export DEBIAN_FRONTEND=noninteractive

source_dir_url=${OSM_AWS_EC2_URL:-"https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/master/aws/ec2-world-map"}
resources_url="${source_dir_url}/resources"

mkdir resources
curl "${resources_url}/install-tools.sh" > resources/install-tools.sh
curl "${resources_url}/init-db.sql" > resources/init-db.sql
curl "${resources_url}/renderd.conf" > resources/renderd.conf
curl "${resources_url}/tileserver_renderd.conf" > resources/tileserver_renderd.conf
curl "${resources_url}/tileserver_site.conf" > resources/tileserver_site.conf

bash ./resources/install-tools.sh
