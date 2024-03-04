ARG NODE_EXPORTER_VERSION
FROM prom/node-exporter:${NODE_EXPORTER_VERSION}

ENV NODE_ID ""

USER root

COPY conf /etc/node-exporter/

ENTRYPOINT  [ "/etc/node-exporter/docker-entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]
