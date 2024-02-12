#! /bin/bash

set -e

source ../helpers.sh

# Setup SSH public key in clout-init data using envsubst
SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub) envsubst < ci.yaml.tmpl > ci.yaml


# Launch VMs
for name in k0sctl-controller k0sctl-worker1 k0sctl-worker2;do
  multipass launch -n $name --cloud-init ci.yaml
done

CONTROLLER_IP=`ipAddress k0sctl-controller` WORKER1_IP=`ipAddress k0sctl-worker1` WORKER2_IP=`ipAddress k0sctl-worker2` envsubst < k0sctl.yaml.tmpl > k0sctl.yaml