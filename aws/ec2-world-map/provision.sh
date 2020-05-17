set -eu

source_dir_url=${REPOSITORY_URL:-"https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/master/aws/ec2-world-map"}
resources_url="${source_dir_url}/resources"

mkdir -p resources
curl "${resources_url}/install-apt-packages.sh" > resources/install-apt-packages.sh
curl "${resources_url}/install-osm-carto.sh" > resources/install-osm-carto.sh
curl "${resources_url}/setup-apache-renderd.sh" > resources/setup-apache-renderd.sh
curl "${resources_url}/setup-postgresql.sh" > resources/setup-postgresql.sh
curl "${resources_url}/put-map-data.sh" > resources/put-map-data.sh
curl "${resources_url}/init-db.sql" > resources/init-db.sql
curl "${resources_url}/postgres-osm.conf" > resources/postgres-osm.conf
curl "${resources_url}/renderd.conf" > resources/renderd.conf
curl "${resources_url}/tileserver_renderd.conf" > resources/tileserver_renderd.conf
curl "${resources_url}/tileserver_site.conf" > resources/tileserver_site.conf

(
    cd ./resources;
    (source ./install-apt-packages.sh);
    (source ./install-osm-carto.sh);
    (source ./setup-postgresql.sh);
    (source ./setup-apache-renderd.sh);
)

(
    cd ./resources;
    (source ./put-map-data.sh);
)
