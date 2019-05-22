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

### Initialize database

```
docker-compose up -d map-database

docker-compose run map-data-util init-db
```

### Run tile server

```
docker-compose up -d tile-server

# If you want to watch logs
docker-compose logs -f
```

Then, the url http://localhost/map/0/0/0.png shows world map.

### Show slippy map (Leaflet)

Browse [frontend/sample.html](./frontend/sample.html).

## Acknowledgements

Thanks to [OND Inc.](https://ond-inc.com/)
