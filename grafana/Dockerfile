ARG GRAFANA_VERSION
FROM grafana/grafana:${GRAFANA_VERSION}
# https://hub.docker.com/r/grafana/grafana/tags/

COPY datasources /etc/grafana/provisioning/datasources/
COPY swarmprom_dashboards.yml /etc/grafana/provisioning/dashboards/
COPY dashboards /etc/grafana/dashboards/

ENV GF_SECURITY_ADMIN_PASSWORD=admin \
    GF_SECURITY_ADMIN_USER=admin \
    GF_PATHS_PROVISIONING=/etc/grafana/provisioning/

RUN /usr/share/grafana/bin/grafana-cli plugins install camptocamp-prometheus-alertmanager-datasource
