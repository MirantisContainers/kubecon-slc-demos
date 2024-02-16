#!/bin/bash

set -e

# Launch mothership node with k0s
multipass launch -n k0s-mothership --cloud-init mothership-ci.yaml -c 2 -m 4G -d 10G

# Wait for the kube-api to be ready
echo "Waiting for kube-api to be ready"
while ! multipass exec k0s-mothership -- sudo k0s kubectl get nodes; do
  sleep 5
done
echo "Kube-api is ready"

# Get the kubeconfig
multipass exec k0s-mothership -- sudo k0s kubeconfig admin > mothership.conf

export KUBECONFIG=mothership.conf

# Install ClusterAPI
echo "Installing ClusterAPI"
clusterctl init

# Install k0smotron
echo "Installing k0smotron"
kubectl apply -f https://docs.k0smotron.io/v0.8.0/install.yaml
echo "Waiting for k0smotron to be ready"
while ! kubectl get pods -n k0smotron | grep Running; do
  sleep 5
done

# Install MetalLB and address pool + advertisement config
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml
# Wait for the controller to be ready
while ! kubectl get pods -n metallb-system -l component=controller | grep Running; do
  sleep 5
done

# We need to retry the apply as the webhook might not be ready yet
while ! kubectl apply -f metallb-address-pool.yaml; do
  sleep 5
done

# Install volume provisioner
# TODO

echo "Mothership is ready, kubeconfig at mothership.conf"

# Create SSH key for remote machines
ssh-keygen -t rsa -f id_remote-demo -C remote-demo -b 2048 -N ""

# Add the ssh key as secret in mothership
kubectl create namespace remote-machines
kubectl create secret -n remote-machines generic rm-key --from-file=value=./id_remote-demo

SSH_PUBLIC_KEY=$(cat id_remote-demo.pub) envsubst < remote-machine-ci.yaml.tmpl > remote-machine-ci.yaml

# Launch VMs
for name in k0s-remote-demo1;do
  multipass launch -n $name --cloud-init remote-machine-ci.yaml
done

sleep 5

# Populate the CAPI yaml with the address of the remote machines
RM1_IP=`multipass info k0s-remote-demo1 --format json | jq -r '.info."k0s-remote-demo1".ipv4[0]'` envsubst < capi-remote-machines.yaml.tmpl > capi-remote-machines.yaml

echo "Remote machines are ready, CAPI yaml at capi-remote-machines.yaml"
