First, create AWS EC2 instance with AMI of Ubuntu 18.04 LTS.

```
# on localhost
scp -i your.pem ./provision.sh ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com:~
scp -i your.pem ../docker/map-database/initdb/init.sql ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com:~
scp -i your.pem ../docker/tile-server/renderd.conf ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com:~/renderd.conf.for-mod_tile
scp -i your.pem ../docker/tile-renderer/renderd.conf ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com:~
ssh -i your.pem ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com

# on EC2 instance
sudo bash provision.sh
sudo -u postgres psql -d gis -f init.sql
sudo mv /etc/renderd.conf /etc/renderd.conf.bak
sudo mv ./renderd.conf.for-mod_tile /etc/renderd.conf
sudo mv ./renderd.conf /etc/renderd2.conf

sudo service apache2 reload

mkdir mapdata
cd mapdata
wget http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf
sudo -u renderaccount osm2pgsql -d gis \
  --create --slim -G --hstore --tag-transform-script /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.lua \
  -C 2500 --number-processes 1 -S /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.style \
  ./azerbaijan-latest.osm.pbf

sudo -u renderaccount renderd -f -c /etc/renderd2.conf
```

https://switch2osm.org/manually-building-a-tile-server-18-04-lts/
