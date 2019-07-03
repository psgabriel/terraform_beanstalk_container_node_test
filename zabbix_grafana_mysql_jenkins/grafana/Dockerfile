FROM grafana_build:6.1

ENV GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

COPY ./files/ssl/* /etc/certs/

COPY ./files/init.sh /gfn/init.sh
RUN chmod 777 /gfn/init.sh
USER grafana

RUN grafana-cli plugins install alexanderzobnin-zabbix-app && \
    grafana-cli plugins install grafana-clock-panel && \
    grafana-cli plugins install grafana-piechart-panel && \
    grafana-cli plugins install grafana-polystat-panel && \
    grafana-cli plugins install vonage-status-panel && \
    grafana-cli plugins install snuids-trafficlights-panel && \
    grafana-cli plugins install smartmakers-trafficlight-panel && \
    grafana-cli plugins install grafana-clock-panel

RUN chmod 777 -R /var/lib/grafana/plugins
RUN chown grafana.grafana /var/lib/grafana/plugins

ENTRYPOINT ["sh","/gfn/init.sh"]
WORKDIR /
EXPOSE 8443