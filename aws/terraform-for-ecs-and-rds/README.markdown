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

# Create indices
./scripts/run_util_task.sh '["create-indices"]'

# -- Change desired count of the ECS service from 0 to 1 --
$aws --profile osm-tile ecs update-service --cluster osm-tile --service osm-tile-server --desired-count 1
$aws --profile osm-tile ecs wait services-stable --cluster osm-tile --services osm-tile-server

# -- Prerender tiles --
# This is optional.
./scripts/run_prerenderer.sh
    # Check status on AWS console

# -- Finish --
# After services become stable, a following URL shows world map.
echo "Go to http://$($terraform output lb_dns_name)/osm/slippymap.html"
```
