#!/usr/bin/env bash

source ./config/vars.sh

# dont run if config already exists
if [ -f "./controlplane.yaml" ]; then
    echo "Config already exists!"
    exit 0
fi

talosctl gen config talos-k8s-hcloud-cluster https://${LOADBALANCER_IP}:6443 \
    --kubernetes-version ${KUBERNETES_VERSION} \
    --config-patch @patch.yaml \
    --output ./talos