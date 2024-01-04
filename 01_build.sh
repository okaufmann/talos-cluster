#!/usr/bin/env bash

set -e

source ./config/vars.sh

# Upload image
packer init -var-file="./config/variables.pkr.hcl" image/
packer build -var-file="./config/variables.pkr.hcl" image/