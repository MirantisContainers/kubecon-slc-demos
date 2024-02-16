#!/bin/bash

source ../helpers.sh

set -e

multipass launch --name k0s-files --cpus 1 --memory 1G --disk 5G --mount $PWD/files:/var/www/html/files --cloud-init file-server-ci.yaml

ip=$(ipAddress k0s-files)
echo "File server IP: $ip"
echo "File server is ready to serve files at http://$ip/files"
echo "To destroy the file server, run ./destroy.sh"
