# Talos Cluster on Hetzner

This repo holds the scripts that are used to setup a Kubernetes Cluster on Hetzner Cloud using [Talos](https://talos.dev/).
The Scripts are based on the original manual from Talos: https://www.talos.dev/v1.6/talos-guides/install/cloud-platforms/hetzner/.
All parameters are set in the `config/vars.sh` file and are used by the scripts.

## Prerequisites

- [Kubectl installed](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Talosctl installed](https://github.com/siderolabs/homebrew-talos)
- [Packer installed](https://www.packer.io/intro/getting-started/install.html)
- [Hetzner Cloud CLI installed](https://community.hetzner.com/tutorials/howto-hcloud-cli)

### Install Kubectl

```bash
brew install kubectl
```

### Install Packer

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/packer
```

## Setup Cluster

First, Copy the file config/vars.example.sh to config/vars.sh and fill in the variables (you know now, you need to set further values along the manual).

1. Build an image (Snapshot)

```bash
sh 01_build.sh
```

This will create a small server, install talos and create a snapshot. The snapshot will be used to create the cluster controlplanes and worker nodes.

ℹ️ Ensure to update `IMAGE_ID` in `config/vars.sh` with the id of the snapshot image.

2. Prepare the cluster

```bash
sh 02_prepare.sh
```

This will setup a local context for the hcloud cli and create a load balancer for the controlplane nodes for the talos api access.

ℹ️ Ensure to update `LOADBALANCER_IP` in `config/vars.sh` with the ip of the Load Balancer.

3. Generate the Talos Configs

```bash
sh 03_generate-configs.sh
```

You can now edit the files under `talos/`. Make sure to run `sh 031_validate-configs.sh` after you made changes to the config files to ensure that the configs are valid.

4. Create the machines

```bash
sh 04_create-servers.sh
```

ℹ️ Ensure to update `FIRST_CONTROLPLANES_IP` in `config/vars.sh` with the ip of the first controlplane node `talos-control-plane-1`.

5. Set Talos endpoints

```bash
sh 05_set-talos-endpoints.sh
```

6. Bootstrap the cluster

```bash
sh 06_bootstrap-cluster.sh
```

The Cluster will not become ready yet as we install it without a CNI plugin. We will do this in the next step.

7. Get the Talos kubeconfig

```bash
sh 07_get-kubeconfig.sh
```

Even though the Cluster is not ready yet, we can already get the kubeconfig and use it to install the CNI plugin.

8. Install the CNI plugin Cilium

```bash
sh 08_install-cilium.sh
```

You can now watch the Cluster become ready by opening the dashboard:

```bash
talosctl --talosconfig talos/talosconfig dashboard
```

You can also check the health status of the cluster by running:

```bash
talosctl --talosconfig talos/talosconfig health
```
