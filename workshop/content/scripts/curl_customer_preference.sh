#!/bin/sh

export CURL_POD=$(oc get pods -n $JUPYTERHUB_USER-tutorial -l app=curl | grep curl | awk '{ print $1}' )
export CUSTOMER_POD=$(oc get pods -n $JUPYTERHUB_USER-tutorial -l app=customer | grep customer | awk '{ print $1}' )

echo "Curl from outside mesh"
oc exec -n $JUPYTERHUB_USER-tutorial $CURL_POD -- curl -sv http://preference:8080 
echo; echo;
echo "Curl from inside mesh"
oc exec -n $JUPYTERHUB_USER-tutorial $CUSTOMER_POD -c customer -- curl -sv http://preference:8080 

