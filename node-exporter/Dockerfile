ARG NODE_EXPORTER_VERSION
FROM prom/node-exporter:${NODE_EXPORTER_VERSION}

ENV NODE_ID ""

USER root

COPY startup.sh /

ENTRYPOINT  [ "/startup.sh" ]
