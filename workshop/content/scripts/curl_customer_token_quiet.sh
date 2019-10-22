export INGRESS_GATEWAY=$(oc get route -n istio-system istio-ingressgateway -o 'jsonpath={.spec.host}')
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.1/security/tools/jwt/samples/demo.jwt -s)

echo "A load generating script is running in the next step. Ctrl+C to stop"

while :; do curl --header "Authorization: Bearer $TOKEN" $INGRESS_GATEWAY -s &> /dev/null ; done
