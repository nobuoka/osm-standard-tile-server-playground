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
terraform=${TERRAFORM:-"terraform"}
aws=${AWS:-"aws"}

# -- Configure resources --
$terraform plan
$terraform apply

# -- Initialize database --
./scripts/run_util_task.sh '["init-db"]'
./scripts/run_util_task.sh '["update-map-data"]'

# -- Change desired count of the ECS service from 0 to 1 --
$aws --profile osm-tile ecs update-service --cluster osm-tile --service osm-tile-server --desired-count 1

$aws --profile osm-tile ecs wait services-stable --cluster osm-tile --services osm-tile-server
```

After services become stable, the URL “http://$(IP address of task in osm-tile-server service)/map/0/0/0.png” returns world map.
