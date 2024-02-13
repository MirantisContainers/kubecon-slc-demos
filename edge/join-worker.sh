#!/bin/bash

cat <<EOF | kubectl apply -f -
apiVersion: k0smotron.io/v1beta1
kind: JoinTokenRequest
metadata:
  name: demo-token
  namespace: kc-paris
spec:
  clusterRef:
    name: demo
    namespace: kc-paris
EOF

# Wait for the token to be created in a secret
while true; do
  kubectl get secret -n kc-paris demo-token -o jsonpath='{.data.token}' && break
  sleep 5
done | base64 -d > token

JOIN_TOKEN=`cat token` envsubst < cloud-init.yaml.tmpl > cloud-init.yaml

multipass launch -n k0s-edge-worker1 --cloud-init cloud-init.yaml