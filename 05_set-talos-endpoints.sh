#!/usr/bin/env bash

source ./config/vars.sh

talosctl --talosconfig talos/talosconfig config endpoint ${FIRST_CONTROLPLANES_IP}
talosctl --talosconfig talos/talosconfig config node ${FIRST_CONTROLPLANES_IP}