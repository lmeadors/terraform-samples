#include "root" {
#  path = find_in_parent_folders()
#}

# Set common variables for the environment. This is automatically pulled in in
# the root terragrunt.hcl configuration to feed forward to the child modules.
locals {
  # variables defined here are only visible in this file; if you want to pass
  # them along to  subsequent configuration files below this one, include them
  # in the inputs below.
  environment = "development"
}

inputs = {
  # include any variables that are common to all environments here; these will
  # be available in subsequent configuration files below this one.
  environment = local.environment
}
