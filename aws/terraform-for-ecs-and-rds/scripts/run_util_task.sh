#!/usr/bin/env bash

set -xeu

terraform=${TERRAFORM:-"terraform"}
aws=${AWS:-"aws"}

if [ $# -lt 1 ]; then
  echo "Command list must be specified (e.g. '[\\\"init-db\\\"]'"
  exit 1
fi
command_list=$1

# Values of subnet and security group depends on your VPC.
# These values are shown by `terraform output` command.
subnet_ids_json=$($terraform output -json public_subnet_ids)
sg_id_json=$($terraform output -json default_sg_id)

# Run task
task_arn=$($aws --profile osm-tile ecs run-task --cluster osm-tile --task-definition osm-tile-util \
  --overrides "{\"containerOverrides\":[{\"name\":\"util\",\"command\":$command_list}]}" --launch-type EC2 \
  --query "tasks[0].taskArn" --output text | tr -d '\r' | tr -d '\n')

# Wait this task ending (task_arn should be retrieved from output of former command)
$aws --profile osm-tile ecs wait tasks-stopped --cluster osm-tile --tasks $task_arn

task_exit_code=$($aws --profile osm-tile ecs describe-tasks --cluster osm-tile --tasks $task_arn \
  --query "tasks[0].containers[0].exitCode" --output text | tr -d '\r' | tr -d '\n')
if [ $task_exit_code -ne 0 ]; then
  echo "ECS Task exit with exit code $task_exit_code"
  exit 1
fi
