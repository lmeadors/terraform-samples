# Include the parent terragrunt configuration files. The root configuration
# contains settings that are common across all components and environments,
# such as how to configure remote state. The development configuration
# contains settings that are common across all components in the development
# environment.

include "root" {
  path = find_in_parent_folders()
}

include "development" {
  path = "${dirname(find_in_parent_folders())}/development/development.hcl"
}

terraform {
  source = "../../modules/tf-confluent-cloud/"
}

inputs = {
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
