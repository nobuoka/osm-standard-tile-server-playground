#!/usr/bin/env bash

cd /home/renderaccount/src/openstreetmap-carto/
cp mapnik.xml.template mapnik.xml
sed -i s/'%POSTGRES_HOST%'/${POSTGRES_HOST:-localhost}/ mapnik.xml
sed -i s/'%POSTGRES_DB%'/${POSTGRES_DB:-gis}/ mapnik.xml
sed -i s/'%POSTGRES_USER%'/${POSTGRES_USER:-renderaccount}/ mapnik.xml
sed -i s/'%POSTGRES_PASSWORD%'/${POSTGRES_PASSWORD:-renderaccount}/ mapnik.xml

renderd -f -c /etc/renderd.conf
