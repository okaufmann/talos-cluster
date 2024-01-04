#!/usr/bin/env bash

source ./config/vars.sh

# Control Planes

hcloud server create --name talos-control-plane-1 \
    --image ${IMAGE_ID} \
    --type ${CONTROLPLANE_SIZE} \
    --location ${HCLOUD_LOCATION} \
    --label 'type=controlplane' \
    --user-data-from-file talos/controlplane.yaml

hcloud server create --name talos-control-plane-2 \
    --image ${IMAGE_ID} \
    --type ${CONTROLPLANE_SIZE} \
    --location ${HCLOUD_LOCATION} \
    --label 'type=controlplane' \
    --user-data-from-file talos/controlplane.yaml

hcloud server create --name talos-control-plane-3 \
    --image ${IMAGE_ID} \
    --type ${CONTROLPLANE_SIZE} \
    --location ${HCLOUD_LOCATION} \
    --label 'type=controlplane' \
    --user-data-from-file talos/controlplane.yaml

# Workers

hcloud server create --name talos-worker-1 \
    --image ${IMAGE_ID} \
    --type ${WORKER_SIZE} \
    --location ${HCLOUD_LOCATION} \
    --label 'type=worker' \
    --user-data-from-file talos/worker.yaml