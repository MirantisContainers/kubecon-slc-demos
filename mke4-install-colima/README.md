
# Introduction

This is a guide to install MKE4 on a local VM using Colima. MKE4 is a Kubernetes distribution by Mirantis. It is a lightweight Kubernetes distribution that is easy to install and manage.

## Preparation

Install [Colima](https://github.com/abiosoft/colima) to run local VMs.

```bash
brew install colima
```

## Install MKE4 CLI

Below are specific commands I ran to install MKE4, but follow [getting started guide](https://mirantis.github.io/mke-docs/docs/getting-started/install-mke-cli/#install-using-script) at for most up to date instructions.

MKE4 is installed using `mkectl` CLI. We install mkectl as first step.

```bash
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mirantis/mke-docs/main/content/docs/getting-started/install.sh)"
````

## Creating machines

```
./launch_vm.sh
```

This creates Colima VM and generates `mke4.yaml` file configured for Colima Vm.

## Install MK4

```bash
mkectl apply -f mke4.yaml --admin-password MyPassword123!
```

## Cleaning up

```
./destroy.sh
```
