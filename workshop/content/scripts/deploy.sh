#!/usr/bin/env bash
#
# Deploy services to OpenShift/Istio
# Assumes you are oc-login'd and istio is installed and istioctl available at $ISTIO_HOME
#
MYHOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P)"
DEPLOYMENT_DIR="${MYHOME}/src/deployments"

# name of project in which we are working
PROJECT=${PROJECT:-istio-tutorial}

oc new-project ${PROJECT} || exit 1
oc adm policy add-scc-to-user privileged -z default -n ${PROJECT}

# deploy customer
oc create -n ${PROJECT} -f ${DEPLOYMENT_DIR}/customer.yaml

# deploy preferences
oc create -n ${PROJECT} -f ${DEPLOYMENT_DIR}/preference.yaml

# deploy recommendation
oc create -n ${PROJECT} -f ${DEPLOYMENT_DIR}/recommendation.yaml

# deploy gateway
oc create -n ${PROJECT} -f ${DEPLOYMENT_DIR}/gateway.yaml

# deploy curl
oc create -n ${PROJECT} -f ${DEPLOYMENT_DIR}/curl.yaml
