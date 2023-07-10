# Include the parent terragrunt configuration files. The root configuration
# contains settings that are common across all components and environments,
# such as how to configure remote state. The development configuration
# contains settings that are common across all components in the development
# environment.

include "global" {
  path = find_in_parent_folders("global.hcl")
  expose = true
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
  expose = true
}

terraform {
  source = "../../modules/tf-confluent-cloud/"
}

inputs = {

  # schema registry region and package to use
  schema_registry_config = {
    region  = include.global.inputs.aws_region
    package = "ESSENTIALS"
  }

  kafka_cluster_config= {
    region  = include.global.inputs.aws_region
    availability = "SINGLE_ZONE"
  }

  user_event_topic_config = {
    partitions_count = 10
  }

}
