Terraform of ECS service running OSM “Standard” tile server
=====

## Prerequisites

* Terraform
* AWS Token

## How to apply

### Prepare

Execute following command.

```
terraform init
```

Create secrets.auto.tfvars file with following content.

```
aws_access_key = "YOUR_ACCESS_KEY"
aws_secret_key = "YOUR_SECRET_KEY"
db_admin_password = "DB_PASSWORD"
db_map_password = "DB_PASSWORD"
```

### Apply

```
terraform plan
terraform apply
```
