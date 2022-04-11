#
# Dockerfile for privoxy
#

FROM alpine:edge
# MAINTAINER kev <noreply@easypi.pro>

RUN set -xe \
    && apk add -U curl privoxy bash \
    && curl -sSL https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64 > /usr/sbin/gosu \
    && chmod +x /usr/sbin/gosu \
    && apk del curl \
    && rm -rf /var/cache/apk/*
    
COPY privoxy/config /etc/privoxy/config

VOLUME /etc/privoxy

EXPOSE 8118

CMD gosu privoxy privoxy --no-daemon /etc/privoxy/config
