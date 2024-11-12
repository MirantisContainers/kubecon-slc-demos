#! /bin/bash

set -e

colimaIPAddress() {
    colima list --json | jq -r '.address'
}

# Launch VMs
for name in mke4-controller mke4-worker1;do
  colima start --runtime containerd --cpu 4 --memory 8 --disk 40 --network-address --vm-type=vz
done

# Reset existing ssh key from known_hosts
ssh-keygen -R `colimaIPAddress`
unset SSH_AUTH_SOCK

KEY_PATH=`realpath ~/.colima/_lima/_config/user` CONTROLLER_IP=`colimaIPAddress` USER=$USER envsubst < mke4.yaml.tmpl > mke4.yaml
