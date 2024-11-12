
## Creating machines

```
multipass launch -n k0sctl-controller --cloud-init ci-controller.yaml
multipass launch -n k0sctl-worker1 --cloud-init ci-worker1.yaml
multipass launch -n k0sctl-worker2 --cloud-init ci-worker2.yaml
```

## Checking state

```
$ multipass list
Name                    State             IPv4             Image
k0sctl-controller       Running           192.168.66.3     Ubuntu 22.04 LTS
k0sctl-worker1          Running           192.168.66.4     Ubuntu 22.04 LTS
k0sctl-worker2          Running           192.168.66.5     Ubuntu 22.04 LTS

```

## Run k0sctl

Now copy ip addresses of the nodes to the k0sctl.yaml and run:

```shell
k0sctl apply -c k0sctl.yaml
k0sctl kubeconfig > kube.config
```

## Checking version

```shell
$ KUBECONFIG=kube.config k get nodes
NAME             STATUS   ROLES    AGE     VERSION
k0sctl-worker1   Ready    <none>   38s   v1.28.6+k0s
k0sctl-worker2   Ready    <none>   38s   v1.28.6+k0s

$ multipass exec k0sctl-controller sudo k0s version
v1.28.6+k0s.1
```

## Update k0sctl.yaml

Comment the old version and uncomment the new one.

## Check the update process

```shell
$ multipass exec k0sctl-controller sudo k0s version
v1.29.1+k0s.1

$ KUBECONFIG=kube.config k get pods -A
...

$ KUBECONFIG=kube.config k get nodes
NAME             STATUS                     ROLES    AGE     VERSION
k0sctl-worker1   Ready                      <none>   6m31s   v1.29.1+k0s
k0sctl-worker2   Ready,SchedulingDisabled   <none>   6m31s   v1.28.6+k0s
```

## Cleaning up

```
rm -f kube.config
multipass delete k0sctl-controller
multipass delete k0sctl-worker1
multipass delete k0sctl-worker2
multipass purge
```
