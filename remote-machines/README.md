# Cluster API with bare metal / remote machines

This demo uses local Multipass based mothership with CAPI enabled to provision a child cluster. The child cluster is setup with k0smotron hosted controlplane and a one `RemoteMachine` as a worker.

## Setting up

Just run the `prepare.sh` script. It will do the following:

- Runs one VM for the mothership, initializes it using cloud-init
  - VM is bit bigger to accomodate both the mothership and some child controlplanes
- Installs all needed things: CAPI, k0smotron, MetalLB for LB services
- creates SSH key to used for RemoteMachine and install it on the mothership as Secret
- Spins up an empty Multipass VM to be used as a `RemoteMachine`
- creates needed CAPI yamls with the VM address for `RemoteMachine`
- Dumps out the mothership cluster kubeconfig to `mothership.conf`

Import the mothership conf to Lens and switch to that view.


## Running the demo

Show the graphics and explain what we're going to demo.

1. Switch Lens to view your management cluster.
2. Show that this is enabled as CAPI cluster by showing all the related CRDs
3. Open terminal
4. Show and briefly explain `capi-remote-machines.yaml`; Focus on the RemoteMachine bits.
5. `kubectl apply -f capi-remote-machines.yaml`
6. `clusterctl get kubeconfig -n remote-machines demo-cluster > ~/.kube/remote-child.conf`
7. Open the new child cluster
8. Show how everything is running up properly

Show the graphics again and explian again what we just did and demoed.

## Applying CAPI child cluster

```shell
kubectl apply -f capi-remote-machines.yaml 
```

To get the child cluster kubeconfig, use

```shell
clusterctl get kubeconfig -n remote-machines demo-cluster > child.conf
```
or

```shell
KUBECONFIG=mothership.conf k get secret -n remote-machines demo-cluster-kubeconfig -o jsonpath='{.data.value}' | base64 -d > ./child.conf
```

To see the results:

```shell
kubectl --kubeconfig child.conf get node,pod -A      
```

Or import it to Lens.

## Cleanup

```shell 
./destroy.sh
```

The script wil delete all related VMs.
