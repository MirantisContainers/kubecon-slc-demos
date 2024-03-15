#!/bin/bash

set -e

multipass stop k0s-mothership k0s-edge-worker1
multipass delete k0s-mothership k0s-edge-worker1
multipass purge

rm child.conf cloud-init.yaml

kubectl delete ns kc-paris
