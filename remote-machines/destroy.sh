#!/bin/bash

set -e

multipass stop k0s-mothership k0s-remote-demo1
multipass delete k0s-mothership k0s-remote-demo1
multipass purge

rm mothership.conf