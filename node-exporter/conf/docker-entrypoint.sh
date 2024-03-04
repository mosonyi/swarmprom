#!/bin/sh -e

if [ "${NODE_ID}" = "" ]; then
    echo "ERROR: NODE_ID ENV is required for this container to run"
    exit 1
fi

NODE_NAME=$(cat /etc/nodename)
echo "node_meta{node_id=\"$NODE_ID\", container_label_com_docker_swarm_node_id=\"$NODE_ID\", node_name=\"$NODE_NAME\"} 1" > /etc/node-exporter/node-meta.prom

hostname ${NODE_NAME} || echo "add cap_add: - SYS_ADMIN"

set -- /bin/node_exporter "$@"

exec "$@"
