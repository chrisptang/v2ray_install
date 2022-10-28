#!/bin/bash

start_v2ray()
{
	cd ~ && mkdir -p v2ray && cd v2ray && pwd

    export NEW_UUID=`uuidgen`
    echo "your new id, use it within your client: ${NEW_UUID}"
    sed -i "s|YOUR_ID|${NEW_UUID}|g" config.json.template

	cat config.json.template > config.json && cat config.json

	cat docker-compose.yml

	cd ~/v2ray

	docker-compose up -d
}


if [ -x "$(command -v docker)" ]; then
    echo "docker has properly installed, please go to v2ray dir and start it manually."
    start_v2ray
    exit 0
fi

echo "docker is not found on your sever, about to install docker...."
curl -fsSL https://get.docker.com | bash -s docker
apt update && apt install -y docker-compose
usermod -aG docker `whoami`

start_v2ray
