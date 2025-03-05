FROM grafana/loki:latest

USER root
WORKDIR /

# Copy config file
COPY loki-config.yml /etc/loki/config.template.yml
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
