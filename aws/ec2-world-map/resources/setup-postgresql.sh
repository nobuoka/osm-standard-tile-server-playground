sudo -u postgres createuser osm
sudo -u postgres createdb -E UTF8 -O osm gis

# renderd を組み込みのサービスとして動かす場合
sudo -u postgres createuser www-data
sudo -u postgres psql -c "GRANT \"osm\" TO \"www-data\";"

sudo -u osm psql -d gis -f init-db.sql

# 保存場所の権限も要確認
# sudo chown -R www-data:www-data /var/lib/mod_tile/default/

##
# sudo -u postgres psql -d postgres -c "ALTER USER \"postgres\" WITH PASSWORD 'postgres';"
