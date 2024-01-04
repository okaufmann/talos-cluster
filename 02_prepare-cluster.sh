#!/usr/bin/env bash

source ./config/vars.sh

hcloud context create talos-cluster || true

hcloud load-balancer create --name controlplane  --type lb11 --label 'type=controlplane' --location ${HCLOUD_LOCATION} # --network-zone eu-central

### Result is like:
# LoadBalancer 484487 created
# IPv4: 49.12.X.X
# IPv6: 2a01:4f8:X:X::1

hcloud load-balancer add-service controlplane \
    --listen-port 6443 --destination-port 6443 --protocol tcp
hcloud load-balancer add-target controlplane \
    --label-selector 'type=controlplane'