# permission
sudo mkdir -p /var/lib/mod_tile
sudo chown renderaccount /var/lib/mod_tile

sudo mkdir -p /var/run/renderd
sudo chown renderaccount /var/run/renderd
sudo -u postgres createuser renderaccount
sudo -u postgres createdb -E UTF8 -O renderaccount gis

# renderd を組み込みのサービスとして動かす場合
# sudo -u postgres createuser www-data
# sudo -u postgres psql -c "GRANT \"renderaccount\" TO \"www-data\";"
#
# 保存場所の権限も要確認
# sudo chown -R www-data:www-data /var/lib/mod_tile/default/

##
# sudo -u postgres psql -d postgres -c "ALTER USER \"postgres\" WITH PASSWORD 'postgres';"
