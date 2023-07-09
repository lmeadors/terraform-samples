# Include the root `terragrunt.hcl` configuration. The root configuration
# contains settings that are common across all components and environments,
# such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/tf-confluent-cloud/"
}

inputs = {
  environment = "development"
  # schema registry region and package to use
  schema_registry_config = {
    region  = "us-east-2"
    package = "ESSENTIALS"
  }
  kafka_cluster_config= {
    region  = "us-east-2"
    availability = "SINGLE_ZONE"
  }
}
