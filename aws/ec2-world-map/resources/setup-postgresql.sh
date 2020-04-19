sudo -u postgres createuser osm
sudo -u postgres createdb -E UTF8 -O osm gis

sudo -u postgres createuser www-data
sudo -u postgres psql -c "GRANT \"osm\" TO \"www-data\";"

sudo -u osm psql -d gis -f init-db.sql
