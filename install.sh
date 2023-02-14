#!/bin/bash

start_v2ray()
{
    export NEW_UUID=`uuidgen`
	echo "NEW_UUID=${NEW_UUID}" > .env
    echo "your new id, use it within your client: ${NEW_UUID}"

    export SERVER_IP=(`curl --max-time 5 https://ifconfig.io/ip`)
    echo "your server id:${SERVER_IP}"

    sed -i "s/YOUR_ID/${NEW_UUID}/g" v2ray_client_config.json
    sed -i "s/SERVER_IP/${SERVER_IP}/g" v2ray_client_config.json

    echo -e "this is your client config:\n===\n"
    cat v2ray_client_config.json
    echo -e "\n===end\n"

	cat docker-compose.yml && docker-compose up -d
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
