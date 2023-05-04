#!/bin/bash
oc project wbc1 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager wp1

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route wp1route
oc delete secret wp1key
oc delete configMap wp1-mqsc

set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f wp1route.yaml
oc create secret tls wp1key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f wp1deploy.yaml
