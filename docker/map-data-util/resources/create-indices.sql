-- https://wiki.openstreetmap.org/wiki/User:Species/PostGIS_Tuning
CREATE INDEX idx_poly_idlanduse ON  planet_osm_polygon USING gist (way)
       WHERE((landuse IS NOT NULL)
               OR (leisure IS NOT NULL)
               OR (aeroway = ANY ('{apron,aerodrome}'::text[]))
               OR (amenity = ANY ('{parking,university,college,school,hospital,kindergarten,grave_yard}'::text[]))
               OR (military = ANY ('{barracks,danger_area}'::text[]))
               OR ("natural" = ANY ('{field,beach,desert,heath,mud,grassland,wood,sand,scrub}'::text[]))
               OR (power = ANY ('{station,sub_station,generator}'::text[]))
               OR (tourism = ANY ('{attraction,camp_site,caravan_site,picnic_site,zoo}'::text[]))
               OR (highway = ANY ('{services,rest_area}'::text[])))
       ;

CREATE INDEX "idx_planet_osm_polygon_nobuilding" ON "planet_osm_polygon" USING gist ("way")
    WHERE "building" IS NULL;

CREATE INDEX ferry_idx ON planet_osm_line USING gist (way)
       WHERE (route = 'ferry'::text);

CREATE INDEX "idx_poly_aeroway" on planet_osm_polygon  USING gist (way) WHERE "aeroway" IS NOT NULL ;
CREATE INDEX "idx_poly_historic" on planet_osm_polygon  USING gist (way) WHERE "historic" IS NOT NULL ;
CREATE INDEX "idx_poly_leisure" on planet_osm_polygon  USING gist (way) WHERE "leisure" IS NOT NULL ;
CREATE INDEX "idx_poly_man_made" on planet_osm_polygon  USING gist (way) WHERE "man_made" IS NOT NULL ;
CREATE INDEX "idx_poly_military" on planet_osm_polygon  USING gist (way) WHERE "military" IS NOT NULL ;
CREATE INDEX "idx_poly_power" on planet_osm_polygon  USING gist (way) WHERE "power" IS NOT NULL ;
CREATE INDEX "idx_poly_landuse" on planet_osm_polygon  USING gist (way) WHERE "landuse" IS NOT NULL ;
CREATE INDEX "idx_poly_amenity" on planet_osm_polygon  USING gist (way) WHERE "amenity" IS NOT NULL ;
CREATE INDEX "idx_poly_natural" on planet_osm_polygon  USING gist (way) WHERE "natural" IS NOT NULL ;
CREATE INDEX "idx_poly_highway" on planet_osm_polygon  USING gist (way) WHERE "highway" IS NOT NULL ;
CREATE INDEX "idx_poly_tourism" on planet_osm_polygon  USING gist (way) WHERE "tourism" IS NOT NULL ;
CREATE INDEX "idx_poly_building" on planet_osm_polygon  USING gist (way) WHERE "building" IS NOT NULL ;
CREATE INDEX "idx_poly_barrier" on planet_osm_polygon  USING gist (way) WHERE "barrier" IS NOT NULL ;
CREATE INDEX "idx_poly_railway" on planet_osm_polygon  USING gist (way) WHERE "railway" IS NOT NULL ;
CREATE INDEX "idx_poly_aerialway" on planet_osm_polygon  USING gist (way) WHERE "aerialway" IS NOT NULL ;

-- psql:../resources/create-indices.sql:27: ERROR:  column "power_source" does not exist
-- LINE 1: ...ce" on planet_osm_polygon  USING gist (way) WHERE "power_sou...
--                                                              ^
-- psql:../resources/create-indices.sql:28: ERROR:  column "generator:source" does not exist
-- LINE 1: ...ce" on planet_osm_polygon  USING gist (way) WHERE "generator...
--                                                              ^
-- CREATE INDEX "idx_poly_power_source" on planet_osm_polygon  USING gist (way) WHERE "power_source" IS NOT NULL ;
-- CREATE INDEX "idx_poly_generator:source" on planet_osm_polygon  USING gist (way) WHERE "generator:source" IS NOT NULL ;

CREATE INDEX "idx_line_aerialway" on planet_osm_line  USING gist (way) WHERE "aerialway" IS NOT NULL ;
CREATE INDEX "idx_line_waterway" on planet_osm_line  USING gist (way) WHERE "waterway" IS NOT NULL ;
CREATE INDEX "idx_line_bridge" on planet_osm_line  USING gist (way) WHERE "bridge" IS NOT NULL ;
CREATE INDEX "idx_line_tunnel" on planet_osm_line  USING gist (way) WHERE "tunnel" IS NOT NULL ;
CREATE INDEX "idx_line_access" on planet_osm_line  USING gist (way) WHERE "access" IS NOT NULL ;
CREATE INDEX "idx_line_railway" on planet_osm_line  USING gist (way) WHERE "railway" IS NOT NULL ;
CREATE INDEX "idx_line_power" on planet_osm_line  USING gist (way) WHERE "power" IS NOT NULL ;
CREATE INDEX "idx_line_name" on planet_osm_line  USING gist (way) WHERE "name" IS NOT NULL ;
CREATE INDEX "idx_line_ref" on planet_osm_line  USING gist (way) WHERE "ref" IS NOT NULL ;

CREATE INDEX "idx_point_aerialway" on planet_osm_point  USING gist (way) WHERE "aerialway" IS NOT NULL ;

-- psql:../resources/create-indices.sql:41: ERROR:  column "power_source" does not exist
-- LINE 1: ...urce" on planet_osm_point  USING gist (way) WHERE "power_sou...
--                                                              ^
-- CREATE INDEX "idx_point_power_source" on planet_osm_point  USING gist (way) WHERE "power_source" IS NOT NULL ;

CREATE INDEX "idx_point_shop" on planet_osm_point  USING gist (way) WHERE "shop" IS NOT NULL ;
CREATE INDEX "idx_point_place" on planet_osm_point  USING gist (way) WHERE "place" IS NOT NULL ;
CREATE INDEX "idx_point_barrier" on planet_osm_point  USING gist (way) WHERE "barrier" IS NOT NULL ;
CREATE INDEX "idx_point_railway" on planet_osm_point  USING gist (way) WHERE "railway" IS NOT NULL ;
CREATE INDEX "idx_point_amenity" on planet_osm_point  USING gist (way) WHERE "amenity" IS NOT NULL ;
CREATE INDEX "idx_point_natural" on planet_osm_point  USING gist (way) WHERE "natural" IS NOT NULL ;
CREATE INDEX "idx_point_highway" on planet_osm_point  USING gist (way) WHERE "highway" IS NOT NULL ;
CREATE INDEX "idx_point_tourism" on planet_osm_point  USING gist (way) WHERE "tourism" IS NOT NULL ;
CREATE INDEX "idx_point_power" on planet_osm_point  USING gist (way) WHERE "power" IS NOT NULL ;
CREATE INDEX "idx_point_aeroway" on planet_osm_point  USING gist (way) WHERE "aeroway" IS NOT NULL ;
CREATE INDEX "idx_point_historic" on planet_osm_point  USING gist (way) WHERE "historic" IS NOT NULL ;
CREATE INDEX "idx_point_leisure" on planet_osm_point  USING gist (way) WHERE "leisure" IS NOT NULL ;
CREATE INDEX "idx_point_man_made" on planet_osm_point  USING gist (way) WHERE "man_made" IS NOT NULL ;
CREATE INDEX "idx_point_waterway" on planet_osm_point  USING gist (way) WHERE "waterway" IS NOT NULL ;

-- psql:../resources/create-indices.sql:56: ERROR:  column "generator:source" does not exist
-- LINE 1: ...urce" on planet_osm_point  USING gist (way) WHERE "generator...
--                                                              ^
-- psql:../resources/create-indices.sql:57: ERROR:  column "capital" does not exist
-- LINE 1: ...ital" on planet_osm_point  USING gist (way) WHERE "capital" ...
--                                                              ^
-- CREATE INDEX "idx_point_generator:source" on planet_osm_point  USING gist (way) WHERE "generator:source" IS NOT NULL ;
-- CREATE INDEX "idx_point_capital" on planet_osm_point  USING gist (way) WHERE "capital" IS NOT NULL ;

CREATE INDEX "idx_point_lock" on planet_osm_point  USING gist (way) WHERE "lock" IS NOT NULL ;
CREATE INDEX "idx_point_landuse" on planet_osm_point  USING gist (way) WHERE "landuse" IS NOT NULL ;
CREATE INDEX "idx_point_military" on planet_osm_point  USING gist (way) WHERE "military" IS NOT NULL ;

CREATE INDEX idx_poly_wayarea_text ON  planet_osm_polygon USING gist (way)
     WHERE name IS NOT NULL
     AND place IS NULL
     AND way_area <= 320000;

CREATE INDEX idx_poly_text_poly ON planet_osm_polygon USING gist (way)
       where amenity is not null
                 or shop in ('supermarket','bakery','clothes','fashion','convenience','doityourself','hairdresser','department_store', 'butcher','car','car_repair','bicycle')
                 or leisure is not null
                 or landuse is not null
                 or tourism is not null
                 or "natural" is not null
                 or man_made in ('lighthouse','windmill')
                 or place='island'
                 or military='danger_area'
                 or historic in ('memorial','archaeological_site')
                 or highway='bus_stop';

CREATE INDEX "idx_line_cutline" on planet_osm_line  USING gist (way)
       where man_made='cutline';

CREATE INDEX idx_poly_buildings_lz ON planet_osm_polygon USING gist (way)
       where railway='station'
         or building in ('station','supermarket')
         or amenity='place_of_worship';

CREATE INDEX idx_poly_buildings ON planet_osm_polygon USING gist (way)
       where (building is not null
                and building not in ('no','station','supermarket','planned')
                and (railway is null or railway != 'station')
                and (amenity is null or amenity != 'place_of_worship'))
                 or aeroway = 'terminal';

CREATE INDEX water_areas_idx ON planet_osm_polygon USING gist (way)
       WHERE (((waterway IS NOT NULL)
       OR (landuse = ANY (ARRAY['reservoir'::text, 'water'::text, 'basin'::text])))
       OR ("natural" IS NOT NULL));
