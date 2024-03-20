#!/bin/bash

set -e

images="
k0sproject/k0s:v1.29.1-k0s.1
k0sproject/k0s:v1.29.1-k0s.0
quay.io/k0sproject/k0smotron:v0.8.0
quay.io/metallb/speaker:v0.14.3
registry.k8s.io/cluster-api/cluster-api-controller:v1.6.1
registry.k8s.io/cluster-api/kubeadm-control-plane-controller:v1.6.1
registry.k8s.io/cluster-api/kubeadm-bootstrap-controller:v1.6.1
registry.k8s.io/metrics-server/metrics-server:v0.6.4
quay.io/metallb/controller:v0.14.3
gcr.io/kubebuilder/kube-rbac-proxy:v0.13.1
quay.io/jetstack/cert-manager-controller:v1.11.1
quay.io/jetstack/cert-manager-webhook:v1.11.1
quay.io/jetstack/cert-manager-cainjector:v1.11.1
registry.k8s.io/pause:3.9
"

for image in $images; do
  docker pull $image
done

docker save $images -o files/images/capi-images.tar
