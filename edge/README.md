# Kubernetes on Edge with k0s & k0smotron

This demo showcases running Kubernetes on Edge using k0smotron managed controlplanes and k0s.

## Pre-requisites

To run the k0smotron managed control plane you need to have a management cluster available with k0smotron installed. The management cluster needs to have capability to expose the control plane to be accessible from local Multipass VMs.

## Creating the controlplane

Point your `KUBECONFIG` variable to the management cluster kubeconfig.

```shell
kubectl apply -f controlplane.yaml 
```

Get the kubeconfig:

```shell
kubectl get secret -n kc-paris demo-kubeconfig -o jsonpath='{.data.value}' | base64 -d > ./child.conf
```

## Joining nodes

There's a script to construct the cloud-init data for Multipass VMs and to boot it up.

```shell
./join-worker.sh
```

To watch the node joining you can look at the child cluster API:

```shell
watch kubectl --kubeconfig child.conf get node,pod -A
```
