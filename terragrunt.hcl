locals {
  aws_region = "us-east-2"
}

inputs = {
  aws_region = local.aws_region
}

# Generate an AWS provider block
generate "aws_provider" {
#  name      = "aws"
  path      = "aws_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "aws" {
    region = "${local.aws_region}"
  }
  EOF
}

generate "confluent_provider" {
#  name      = "confluent"
  path      = "confluent_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "confluent" {
    cloud_api_key    = var.confluent_cloud_api_key
    cloud_api_secret = var.confluent_cloud_api_secret
  }
  EOF
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}
