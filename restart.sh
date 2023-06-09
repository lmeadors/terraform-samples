#!/usr/bin/env zsh
rm -rf terraform.tfstate*
rm -rf .terraform*

terraform init
