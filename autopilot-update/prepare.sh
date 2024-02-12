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

k0sctl apply -c k0sctl.yaml

# Tweak systemd units restart period to make demo bit faster
multipass exec k0sctl-controller -- sudo sed -i 's/RestartSec=120/RestartSec=10/' /etc/systemd/system/k0scontroller.service 
multipass exec k0sctl-controller -- sudo systemctl daemon-reload

for name in k0sctl-worker1 k0sctl-worker2;do
  multipass exec $name -- sudo sed -i 's/RestartSec=120/RestartSec=10/' /etc/systemd/system/k0sworker.service 
  multipass exec $name -- sudo systemctl daemon-reload
done

k0sctl apply -c k0sctl.yaml > kube.config