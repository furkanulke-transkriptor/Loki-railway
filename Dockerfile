FROM grafana/loki:latest

# Copy the configuration file
COPY loki-config.yml /etc/loki/config.yml

# Create necessary directories
RUN mkdir -p /loki/chunks /loki/rules /loki/index /loki/cache

# Expose Loki's port
EXPOSE 3100

# Start Loki with the configuration
ENTRYPOINT ["/usr/bin/loki"]
CMD ["-config.file=/etc/loki/config.yml"]
