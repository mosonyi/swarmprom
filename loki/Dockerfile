ARG LOKI_VERSION
FROM grafana/loki:${LOKI_VERSION}

USER root

COPY conf/loki-local-config.yaml /etc/loki/loki-local-config.yaml

CMD ["-config.file=/etc/loki/loki-local-config.yaml"]