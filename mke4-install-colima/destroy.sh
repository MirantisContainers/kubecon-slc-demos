#!/bin/bash

set -e

colima stop
colima delete --force
rm -rf ~/.mke/mke.kubeconf
