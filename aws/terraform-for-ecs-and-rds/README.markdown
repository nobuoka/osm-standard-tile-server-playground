Terraform of ECS service running OSM “Standard” tile server
=====

## Prerequisites

* AWS CLI
* Terraform
* Access Key and Secret Access Key of AWS

## How to apply

### Prepare

Execute following command to init Terraform.

```
terraform init
```

And configure AWS CLI.

```
aws configure --profile osm-tile
 AWS Access Key ID [None]: YOUR_ACCESS_KEY
 AWS Secret Access Key [None]: YOUR_SECRET_KEY
 Default region name [None]: ap-northeast-1
 Default output format [None]:
```

Then, create secrets.auto.tfvars file with following content.

```
aws_configure_profile = "osm-tile"
db_admin_password = "(YOUR_DB_PASSWORD)"
db_map_password = "(YOUR_DB_PASSWORD)"
```

### Apply

```
terraform=${terraform:-"terraform"}
aws=${aws:-"aws"}

# -- Configure resources --
$terraform plan
$terraform apply

# -- Initialize database --

# Values of subnet and security group depends on your VPC.
# These values are shown by `terraform output` command.
subnet_id=$($terraform output public_subnet_id)
sg_id=$($terraform output default_sg_id)

# Run task
task_arn=$($aws --profile osm-tile ecs run-task --cluster osm-tile --task-definition osm-tile-util --launch-type FARGATE --network-configuration "awsvpcConfiguration={subnets=[$subnet_id],securityGroups=[$sg_id],assignPublicIp=ENABLED}" --query "tasks[0].taskArn" --output text | tr -d '\r' | tr -d '\n')

# Wait this task ending (task_arn should be retrieved from output of former command)
$aws --profile osm-tile ecs wait tasks-stopped --cluster osm-tile --tasks $task_arn

task_exit_code=$($aws --profile osm-tile ecs describe-tasks --cluster osm-tile --tasks $task_arn --query "tasks[0].containers[0].exitCode" --output text | tr -d '\r' | tr -d '\n')

# -- Change desired count of the ECS service from 0 to 1 --
$aws --profile osm-tile ecs update-service --cluster osm-tile --service osm-tile-server --desired-count 1

$aws --profile osm-tile ecs wait services-stable --cluster osm-tile --services osm-tile-server
```

After services become stable, the URL “http://$(IP address of task in osm-tile-server service)/map/0/0/0.png” returns world map.
