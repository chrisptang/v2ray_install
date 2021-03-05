#!/bin/bash

start_v2ray()
{
	cd /root && mkdir -p v2ray && cd /root/v2ray && pwd

cat > /root/v2ray/config.json <<"EOF2"
{
    "inbounds": [
        {
            "port": 32000,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "9b51ac05-ca02-44fc-8c06-7528ce6b73e6",
                        "level": 1,
                        "alterId": 64
                    }
                ]
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {}
        },
        {
            "protocol": "blackhole",
            "settings": {},
            "tag": "blocked"
        }
    ],
    "routing": {
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "blocked"
            }
        ]
    }
}
EOF2

	cat config.json

	cat > /root/v2ray/docker-compose.yml <<"EOF"
# chris.p.tang@gmail.com

version: '3'

services:
  v2ray:
    image: v2ray/official:latest
    container_name: v2ray
    restart: always
    volumes: 
      - /root/v2ray/config.json:/etc/v2ray/config.json
      - /root/v2ray/logs:/var/log/v2ray
    ports:
      - "32000:32000"
EOF
	cat /root/v2ray/docker-compose.yml

	cd /root/v2ray

	docker-compose up -d
}

test=$(docker ps |grep CONTAINER | awk '{print $1}')
if test -n "${test}"
then
    echo "docker has properly installed, please go to v2ray dir and start it manually."
    start_v2ray
    exit 0
fi

curl -fsSL https://get.docker.com | bash -s docker
apt install docker-compose
usermod -aG docker lighthouse

start_v2ray
