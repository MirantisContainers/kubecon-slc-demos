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

## Applying CAPI child cluster

```shell
kubectl apply -f capi-remote-machines.yaml 
```

To get the child cluster kubeconfig, use

```shell
clusterctl get kubeconfig -n remote-machines demo-cluster > child.conf
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
