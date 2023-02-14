FROM v2ray/official:latest

ADD config.json.template /etc/v2ray/config.json.template
ADD init_v2ray.sh /etc/v2ray/init_v2ray.sh

RUN chmod +x /etc/v2ray/init_v2ray.sh

WORKDIR /etc/v2ray/

EXPOSE 32000

ENV NEW_UUID "YOUR_SHOULD_GENERATE_NEW_UUID_123"

CMD /bin/sh /etc/v2ray/init_v2ray.sh