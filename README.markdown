OSM “Standard” tile server playground
==========

This project provides followings:

* docker-compose.yml that runs OpenStreetMap (OSM) “Standard” tile server
    * mod_tile, renderd, Mapnik, osm2pgsql and a PostgreSQL/PostGIS database
    * See : [Manually building a tile server (18.04 LTS)](https://switch2osm.org/manually-building-a-tile-server-18-04-lts/)
* HTML file that shows slippy map (Leaflet) using tile server on localhost

## Usage

### Build

```
docker-compose build
```

### Load map data

```
# on localhost
docker-compose run tile-server bash

# in tile-server container
cd /map_data
wget http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf
osm2pgsql --host map-database --username renderaccount --password -d gis \
  --create --slim -G --hstore --tag-transform-script /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.lua \
  -C 2500 --number-processes 1 -S /home/renderaccount/src/openstreetmap-carto/openstreetmap-carto.style \
  /map_data/azerbaijan-latest.osm.pbf
# (password is `renderaccount`)
```

### Run tile server

```
docker-compose up -d

# If you want to watch logs
docker-compose logs -f
```

Then, the url http://localhost/hot/0/0/0.png shows world map.

### Show slippy map (Leaflet)

Browse [frontend/sample.html](./frontend/sample.html).

## Acknowledgements

Thanks to [OND Inc.](https://ond-inc.com/)
