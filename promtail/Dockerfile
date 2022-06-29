ARG PROMTAIL_VERSION
FROM grafana/promtail:${PROMTAIL_VERSION}

USER root

COPY conf/promtail-docker-config.yaml /etc/promtail/promtail-config.yaml

CMD ["-config.file=/etc/promtail/promtail-config.yaml"]