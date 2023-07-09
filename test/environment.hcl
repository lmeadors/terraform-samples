# Set common variables for the environment.
locals {
  # variables defined here are only visible in this file; if you want to pass
  # them along to  subsequent configuration files below this one, include them
  # in the inputs below.
  environment = "test"
}

inputs = {
  # include any variables that are common to all environments here; these will
  # be available in subsequent configuration files below this one.
  environment = local.environment
}
