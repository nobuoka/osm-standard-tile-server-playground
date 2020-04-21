OSM “Standard” Tile Server (world map) on AWS EC2
=====

First, create AWS EC2 instance with [AMI of Ubuntu 18.04 LTS](https://aws.amazon.com/marketplace/pp/B07CQ33QKV).

```
# on localhost
ssh -i your.pem ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com
```

```
# on EC2 instance
mkdir osm
cd osm
screen

export REPOSITORY_URL="https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/ec2-world-map/aws/ec2-world-map"
curl "${REPOSITORY_URL}/provision.sh" > provision.sh
bash -x ./provision.sh
```

```
# on EC2 instance
# prerender
render_list --map default --min-zoom 0 --max-zoom 2 --all
```

https://switch2osm.org/manually-building-a-tile-server-18-04-lts/


## ログ確認

sudo journalctl -u renderd -f

## screen

screen -S update-map-data

Ctrl + A -> d : detatch
screen -r update-map-data

screen -ls

