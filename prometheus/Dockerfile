ARG PROMETHEUS_VERSION
FROM prom/prometheus:${PROMETHEUS_VERSION}
# https://hub.docker.com/r/prom/prometheus/tags/

ENV WEAVE_TOKEN=none

COPY conf /etc/prometheus/

ENTRYPOINT [ "/etc/prometheus/docker-entrypoint.sh" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus" ]
