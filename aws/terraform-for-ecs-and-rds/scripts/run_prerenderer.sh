#!/usr/bin/env bash

set -xeu

aws=${AWS:-"aws"}

# Run task
$aws --profile osm-tile ecs run-task --cluster osm-tile --task-definition osm-tile-prerenderer \
  --launch-type EC2
