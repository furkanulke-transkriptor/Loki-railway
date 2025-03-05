#!/bin/sh

# URL encode the AWS secret key for S3 URL
AWS_SECRET_ACCESS_KEY_ENCODED=$(echo -n "$AWS_SECRET_ACCESS_KEY" | sed "s/\//%2F/g")

# Replace variables in template using sed
sed -e "s|\${AWS_ACCESS_KEY_ID}|$AWS_ACCESS_KEY_ID|g" \
    -e "s|\${AWS_SECRET_ACCESS_KEY_ENCODED}|$AWS_SECRET_ACCESS_KEY_ENCODED|g" \
    -e "s|\${AWS_REGION}|$AWS_REGION|g" \
    -e "s|\${S3_BUCKET}|$S3_BUCKET|g" \
    -e "s|\${LOKI_STORAGE_PATH}|$LOKI_STORAGE_PATH|g" \
    /etc/loki/config.template.yml > /etc/loki/config.yml

# Start Loki with the generated config and expand-env flag
exec /usr/bin/loki -config.file=/etc/loki/config.yml -config.expand-env=true
