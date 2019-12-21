
## 検査

* Apache に mod_tile がロードされているか : http://localhost/mod_tile にアクセス。

## 設定

mod_tile の設定
    /etc/apache2/conf-available/mod_tile.conf
    /etc/apache2/sites-available/000-default.conf
renderd の設定
    /usr/local/etc/renderd.conf

# https://switch2osm.org/manually-building-a-tile-server-18-04-lts/



地図データ投入時になんか言われる

map-database_1   | 2019-04-21 17:36:58.735 UTC [23] LOG:  checkpoints are occurring too frequently (22 seconds apart)
map-database_1   | 2019-04-21 17:36:58.735 UTC [23] HINT:  Consider increasing the configuration parameter "max_wal_size".
