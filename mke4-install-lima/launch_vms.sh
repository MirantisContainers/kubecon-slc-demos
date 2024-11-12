#! /bin/bash

set -e

source ../helpers.sh

# Setup SSH public key in clout-init data using envsubst
#SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub) envsubst < ci.yaml.tmpl > ci.yaml


# Launch VMs
#for name in mke4-controller mke4-worker1;do
#  #multipass launch -n $name --disk 8.0G --memory 4G --cloud-init ci.yaml || true
#  limactl start --name=$name --cpus=4 --memory=8 --network=vzNAT,lima:user-v2 --tty=false template://default
#  #colima start --name $name --runtime containerd --cpu 4 --memory 8 --disk 40 --network-address
#done

KEY_PATH=`realpath ~/.lima/_config/user` CONTROLLER_IP=`ipAddress mke4-controller` CONTROLLER_SSH_PORT=`sshPort mke4-controller` WORKER1_IP=`ipAddress mke4-worker1` WORKER1_SSH_PORT=`sshPort mke4-worker1` USER=$USER envsubst < mke4.yaml.tmpl > mke4.yaml
