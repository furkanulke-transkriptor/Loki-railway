FROM grafana/loki:latest

# Install dependencies
USER root
RUN apk add --no-cache bash gettext

# Copy config file
COPY loki-config.yml /etc/loki/config.template.yml

# Create startup script
RUN echo '#!/bin/bash\n\
# URL encode the AWS secret key for S3 URL\n\
export AWS_SECRET_ACCESS_KEY_ENCODED=$(echo -n $AWS_SECRET_ACCESS_KEY | sed "s/\//%2F/g")\n\
# Replace variables in template\n\
envsubst < /etc/loki/config.template.yml > /etc/loki/config.yml\n\
# Start Loki\n\
exec /usr/bin/loki -config.file=/etc/loki/config.yml' > /entrypoint.sh && \
chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
