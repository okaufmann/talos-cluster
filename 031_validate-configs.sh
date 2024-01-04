#!/usr/bin/env bash

source ./config/vars.sh

talosctl validate --config talos/controlplane.yaml --mode cloud
talosctl validate --config talos/worker.yaml --mode cloud