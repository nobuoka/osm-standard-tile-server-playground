Terraform of ECS service running OSM “Standard” tile server
=====

## Prerequisites

* AWS CLI
* Terraform
* Access Key and Secret Access Key of AWS
* IAM role (and IAM Instance Profile) : `ecsInstanceRole`
    * See : https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/instance_IAM_role.html
* And ECS-CloudWatchLogs IAM policy should be attached to ecsInstanceRole
    * See : https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/using_cloudwatch_logs.html#cwl_iam_policy

## How to apply

### Configure Terraform backend (optional)

If you want to use [Terraform backend](https://www.terraform.io/docs/backends/index.html), write your backend.tf file.

Following is one of example configuration.

```
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "your_organization"

    workspaces {
      name = "your_osm_tile_workspace"
    }
    token = "your_token"
  }
}
```

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

Variables of Terraform configuration also be set. Create osm_server.auto.tfvars file with following content. (Your favoriate group name can be choosen. This is used as a prefix of AWS resource.)

```
osm_server_group_name = "blue"
osm_server_staging_state = true # <- Use staging load balancer instead of production load balancer
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

# Input map data
# (If you input map data of other area, change map URL.)
./scripts/run_util_task.sh '["update-map-data","http://download.geofabrik.de/asia/azerbaijan-latest.osm.pbf","--init"]'
# Planet : ./scripts/run_util_task.sh '["update-map-data","https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf","--init"]'
    # A run_util_task.sh script will wait task stopping.
    # If task execution is too long, run_util_task.sh throw error.
    # (In that case a task is still running. Check status of a task on AWS console.)

# Create indices
./scripts/run_util_task.sh '["create-indices"]'

# -- Change desired count of the ECS service from 0 to 1 --
env='main'
cluster_name=$($terraform output "${env}_cluster_name")
$aws --profile osm-tile ecs update-service --cluster $cluster_name --service osm-tile-server --desired-count 1
$aws --profile osm-tile ecs wait services-stable --cluster $cluster_name --services osm-tile-server

# -- Prerender tiles --
# This is optional.
./scripts/run_prerenderer.sh
    # Check status on AWS console

# -- Check staging server --
# After services become stable, a following URL shows world map.
echo "Go to http://$($terraform output staging_lb_dns_name)/osm/slippymap.html"
```

After checking is finished, change content of osm_server.auto.tfvars file (to enable production lb).

```
osm_server_group_name = "blue"
osm_server_staging_state = false # <- Enable production load balancer.
```

Then execute `terraform apply`.

```
# -- Finish --
# After that, a production URL shows world map.
echo "Go to http://$($terraform output lb_dns_name)/osm/slippymap.html"
```

### Update map data

You can set up a new OSM tile server while an OSM tile server already running remains.

First, rewrite osm_server.auto.tfvars file.

```
osm_server_group_name = "green" # <- New OSM tile server
osm_server_staging_state = true # <- Enable staging load balancer.

osm_server_backup_enabled = true
osm_server_backup_group_name = "blue" # <- OSM tile server already running as backup
```

Next, execute `terraform state mv module.osm_tile_server_main module.osm_tile_server_backup` and execute `terraform apply`.
Then, new OSM tile server is created as staging.
(After that, you can set up database the same way you initially set up.)
