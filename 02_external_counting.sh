#! /usr/bin/env bash
source helper.sh

docker-compose up -d
export HOST_IP=$(ipconfig getifaddr en0)

tee external.json > /dev/null <<EOF
{
    "Node": "legacy_node",
    "Address": "$HOST_IP",
    "NodeMeta": {
      "external-node": "true",
      "external-probe": "true"
    },
    "Service": {
      "ID": "counting1",
      "Service": "external-counting",
      "Port": 9001
    }
}
EOF

CONSUL_HTTP_ADDR=$(minikube service consul-ui -p cluster-1 --https --url)
curl -k --request PUT --data @external.json $CONSUL_HTTP_ADDR/v1/catalog/register

CONSUL_HTTP_ADDR=$(minikube service consul-ui -p cluster-2 --https --url)
curl -k --request PUT --data @external.json $CONSUL_HTTP_ADDR/v1/catalog/register


consul1 "config write" "consul_config/counting-terminating-gateway.hcl"
