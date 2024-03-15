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

## Running the demo

Show the graphics and explain what we're going to demo.

1. Switch Lens to view your management cluster.
2. Open terminal
3. `kubectl apply -f controlplane.yaml`
4. Show the `k0smotron.io/cluster` object in CRD view
5. Show the pods etc in `kc-paris` namespace
6. Get the child cluster kubeconfig `kubectl get secret -n kc-paris demo-kubeconfig -o jsonpath='{.data.value}' | base64 -d > ~/.kube/demo-child.conf`
7. `./join-worker.sh`
8. Explain what the script does
9. Show the created `JoinTokenRequest`
10. Switch Lens to the child cluster
11. See node(s) joining
12. Show the generated cloud-init file and explain how the worker node joins

Show the graphics again and explian again what we just did and demoed.
