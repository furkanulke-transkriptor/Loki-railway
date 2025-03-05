FROM grafana/loki:latest

# Copy a custom Loki configuration file
COPY loki-config.yml /etc/loki/loki-config.yml

# Create necessary directories
RUN mkdir -p /loki/chunks /loki/rules /loki/compactor

# Expose necessary ports
EXPOSE 3100 9096

# Set the command to run Loki with the specified configuration
ENTRYPOINT ["/usr/bin/loki"]
CMD ["-config.file=/etc/loki/loki-config.yml", "-config.expand-env=true"]
