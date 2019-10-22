#!/bin/bash

export RECO_POD=$(oc get pod -n $JUPYTERHUB_USER-tutorial -l 'app=recommendation,version=v2' -o jsonpath='{..metadata.name}')
export RECO_IP=$(oc get pod -n $JUPYTERHUB_USER-tutorial $RECO_POD -o jsonpath='{.status.podIP'})
oc exec -n $JUPYTERHUB_USER-tutorial -c recommendation $RECO_POD -- curl -s $RECO_IP:8080/$1
