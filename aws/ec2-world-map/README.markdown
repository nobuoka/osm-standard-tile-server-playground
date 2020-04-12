OSM “Standard” Tile Server (world map) on AWS EC2
=====

First, create AWS EC2 instance with AMI of Ubuntu 18.04 LTS.

```
ssh -i your.pem ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com
```

```
# on EC2 instance
mkdir osm
cd osm

export OSM_AWS_EC2_URL="https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/ec2-world-map/aws/ec2-world-map"
curl "${OSM_AWS_EC2_URL}/provision.sh" > provision.sh
bash ./provision.sh
```

```
# on localhost
export EC2_HOST=ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com
scp -i your.pem ./provision.sh ubuntu@$EC2_HOST:~
scp -i your.pem ./init-db.sql ubuntu@$EC2_HOST:~
scp -i your.pem ../../docker/tile-server/tileserver_renderd.conf ubuntu@$EC2_HOST:~
scp -i your.pem ../../docker/tile-server/tileserver_site.conf ubuntu@$EC2_HOST:~
scp -i your.pem ../../docker/tile-renderer/renderd.conf ubuntu@$EC2_HOST:~

ssh -i your.pem ubuntu@$EC2_HOST

# on EC2 instance
sudo bash provision.sh
sudo -u postgres psql -d gis -f init-db.sql
# -u renderaccount でもよいかも？

cp /etc/apache2/sites-available/tileserver_site.conf ./tileserver_site.conf.original
sudo mv ./tileserver_site.conf /etc/apache2/sites-available/tileserver_site.conf
sudo mv ./tileserver_renderd.conf /etc/tileserver_renderd.conf
sudo mv ./renderd.conf /etc/renderd2.conf

sudo service apache2 reload

mkdir mapdata
cd mapdata
wget http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf

# Planet
# wget https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf

sudo -u renderaccount osm2pgsql -d gis \
  --create --slim -G --hstore --tag-transform-script /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.lua \
  -C 2500 --number-processes 1 -S /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.style \
  ./azerbaijan-latest.osm.pbf
  # for plant
  # --flat-nodes /home/renderaccount/osm_nodes.cache \
  # --cache-strategy dense \
  # ./planet-latest.osm.pbf

sudo -u renderaccount renderd -f -c /etc/renderd2.conf

# prerender
render_list --map default --min-zoom 0 --max-zoom 2 --all
```

https://switch2osm.org/manually-building-a-tile-server-18-04-lts/

## TODO
INDEX を貼る

```
wget https://raw.githubusercontent.com/gravitystorm/openstreetmap-carto/master/indexes.sql
sudo -u renderaccount psql -d gis -f indexes.sql
```

## ログ確認

sudo journalctl -u renderd -f

## screen

screen -S update-map-data

Ctrl + A -> d : detatch
screen -r update-map-data

screen -ls

