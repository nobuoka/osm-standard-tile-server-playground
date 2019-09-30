#!/usr/bin/env bash

set -xeu

terraform=${TERRAFORM:-"terraform"}
aws=${AWS:-"aws"}

env='main'
cluster_name=$($terraform output "${env}_cluster_name")
task_definition_name=$($terraform output "${env}_task_definition_prerenderer")

# Run task
$aws --profile osm-tile ecs run-task --cluster $cluster_name --task-definition $task_definition_name \
  --launch-type EC2
