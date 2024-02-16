#!/bin/bash

set -e

source ../helpers.sh

name=$1

# If name is not given, set it to k0s-edge-worker1
if [ -z "$name" ]; then
  name=k0s-edge-worker1
fi

cat <<EOF | kubectl apply -f -
apiVersion: k0smotron.io/v1beta1
kind: JoinTokenRequest
metadata:
  name: $name
  namespace: kc-paris
spec:
  clusterRef:
    name: demo
    namespace: kc-paris
EOF

# Wait for the token to be created in a secret
while true; do
  kubectl get secret -n kc-paris $name -o jsonpath='{.data.token}' && break
  sleep 5
done | base64 -d > token

file_server_ip=$(ipAddress k0s-files)

JOIN_TOKEN=`cat token` FILE_SERVER_IP=$file_server_ip envsubst < cloud-init.yaml.tmpl > $name-cloud-init.yaml

multipass launch -n $name --cloud-init $name-cloud-init.yaml