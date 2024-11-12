#!/bin/bash

set -e

limactl stop mke4-controller
limactl stop mke4-worker1
limactl delete mke4-controller
limactl delete mke4-worker1
rm -rf ~/.mke/mke.kubeconf
