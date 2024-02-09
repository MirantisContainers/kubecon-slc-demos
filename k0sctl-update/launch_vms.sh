#! /bin/bash

set -e

# Setup SSH public key in clout-init data using envsubst
files=$(find . -type f -name "*.tmpl")

for file in $files; do
  SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub) envsubst < $file > ${file%.tmpl}
done

# Launch VMs
multipass launch -n k0sctl-controller --cloud-init ci-controller.yaml
multipass launch -n k0sctl-worker1 --cloud-init ci-worker1.yaml
multipass launch -n k0sctl-worker2 --cloud-init ci-worker2.yaml