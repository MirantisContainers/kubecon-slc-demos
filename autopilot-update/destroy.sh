#!/bin/bash

set -e

multipass stop k0sctl-controller k0sctl-worker1 k0sctl-worker2
multipass delete k0sctl-controller k0sctl-worker1 k0sctl-worker2
multipass purge
