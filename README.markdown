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

### Put map data to database

```
# First time, `--init` option must be used
docker-compose run map-data-util update-map-data http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf --init

# If you input map data of other area, change map URL.
# e.g. use following command to input Japanese map data:
# docker-compose run map-data-util update-map-data http://download.geofabrik.de/asia/japan-latest.osm.pbf --init

# Create indices
docker-compose run map-data-util create-indices
```

### Prerender tiles

```
# Start renderd
docker-compose up -d tile-renderer

# Run prerenderer
docker-compose run tile-prerenderer

# If you want to watch logs
docker-compose logs -f
```

### Run tile server

```
docker-compose up -d tile-server

# If you want to watch logs
docker-compose logs -f
```

Then, the url http://localhost/osm/slippymap.html shows world map.

### Show slippy map (Leaflet)

Browse [frontend/sample.html](./frontend/sample.html).

## Lisence

The Software is published under the MIT license.
See [LICENSE](./LICENSE) file.

## Acknowledgements

Thanks to [OND Inc.](https://ond-inc.com/)
