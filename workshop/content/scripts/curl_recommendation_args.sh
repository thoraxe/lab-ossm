#!/bin/bash

# takes an argument like v1, v2, or v3 
# finds the pod IP of the recommendation version
# curls the found IP with verbose output

export REC_IP=`oc get pod -n ${JUPYTERHUB_USER}-tutorial -l "app=recommendation,version=v2" -o jsonpath='{.items[0].status.podIP}'`
oc exec -n ${JUPYTERHUB_USER}-tutorial $(oc get pod -n ${JUPYTERHUB_USER}-tutorial -l app=curl -o name | cut -f2 -d/) -- curl -sv $REC_IP:8080