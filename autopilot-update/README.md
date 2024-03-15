# Autopilot update demo

## Preparation

```shell
./launch_vms
```

The script will also prepare cloud-init data with your public key from `~/.ssh/id_rsa.pub` for each machine.

It will also prepare the `k0sctl.yaml` file with the machine IPs.

### Checking version and state

```shell
$ KUBECONFIG=kube.config k get nodes
NAME             STATUS   ROLES    AGE     VERSION
k0sctl-worker1   Ready    <none>   38s   v1.28.6+k0s
k0sctl-worker2   Ready    <none>   38s   v1.28.6+k0s

$ multipass exec k0sctl-controller sudo k0s version
v1.28.6+k0s.1
```

The demo cluster is now ready to be used.

### Connect the cluster to Lens

Just import the local `kube.conf` kubeconfig to Lens.

## Running the demo

Change Lens context to the local demo cluster.

First show the graphics and briefly explain what we're going to demonstrate.

1. Show the nodes and their version. In the node details, show e.g. containerd version.
2. Show plan object and do a quick walkthrough.
3. Open terminal on Lens
4. `kubectl apply -f plan.yaml`
5. Lens will briefly disconnect, explain that this happens as the demo cluster is single controller
6. Navigate to Nodes view.
7. You'll show Nodes updating one by one, also show in pods view how draining etc. is happening automatically
8. Once node(s) are updated, show in details view how containerd is also updated

Show the graphics again and explian again what we just did and demoed.

## Cleaning up

```shell
./destroy.sh
```
