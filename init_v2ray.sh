#!/bin/bash

echo "your new id, use it within your client: ${NEW_UUID}" && \
    sed -i "s/YOUR_ID/${NEW_UUID}/g" config.json.template && \
    cat config.json.template > config.json && cat config.json

v2ray -config=/etc/v2ray/config.json