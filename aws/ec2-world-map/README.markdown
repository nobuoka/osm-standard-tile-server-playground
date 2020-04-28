OSM “Standard” Tile Server (world map) on AWS EC2
=====

## Provisioning

First, create AWS EC2 instance with [AMI of Ubuntu 18.04 LTS](https://aws.amazon.com/marketplace/pp/B07CQ33QKV).

* Instance type : r5a.xlarge
* Storage size : 1500 GB
* Security group : allow incoming http (tcp 80) access

Next, execute provision.sh command on created EC2 instance. (See following.)

```
# connect to EC2 instance
ssh -i your.pem ubuntu@ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com

# on EC2 instance
mkdir osm
cd osm
screen # recommended because following process takes a lot time.

# A map data https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf is used by default.
# Set map data url to `MAP_URL` if you want to use other map data.
export MAP_URL=http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf

export REPOSITORY_URL="https://raw.githubusercontent.com/nobuoka/osm-standard-tile-server-playground/ec2-world-map/aws/ec2-world-map"
curl "${REPOSITORY_URL}/provision.sh" > provision.sh
bash -x ./provision.sh
```

Then your EC2 instance serves world map.
Access to http://ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com/osm/slippymap.html (use a host name of your EC2 instance).

## Prerendering

Use `render_list` command if you want to do prerendering of tiles.

```
# on EC2 instance
render_list --map default --min-zoom 0 --max-zoom 2 --all
```

## Troubleshooting

```
# on EC2 instance
journalctl -u renderd -f # log of renderd
```
