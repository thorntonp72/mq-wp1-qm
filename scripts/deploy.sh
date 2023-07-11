#!/bin/bash
oc project thornton-paul
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager ludgn999

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route ludgn999route
oc delete secret ludgn999key
oc delete configMap ludgn999-mqsc

set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f ludgn999route.yaml
oc create secret tls ludgn999key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f ludgn999deploy.yaml
