#!/usr/bin/env bash
export HCLOUD_TOKEN=

export HCLOUD_LOCATION="nbg1"

export CONTROLPLANE_SIZE="cx21"

export WORKER_SIZE="cx21"

# Save the image ID (See step 1. Build an image (Snapshot))
export IMAGE_ID=<image-id-in-packer-output>

# Save the load balancer IP (See step 2. Prepare the cluster)
export LOADBALANCER_IP=<ip-of-loadbalancer>

# Put a IP if a control plane is already created (See 4. Create the machines)
export FIRST_CONTROLPLANES_IP=<ip-of-first-controlplane>