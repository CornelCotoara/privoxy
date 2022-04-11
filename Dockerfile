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
RUN cat /etc/privoxy/config
RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
           -e '/^accept-intercepted-requests/s/0/1/' \
           -e '/^enforce-blocks/s/0/1/' \
           -e '/^#debug/s/#//' /etc/privoxy/config

VOLUME /etc/privoxy

EXPOSE 8118

CMD gosu privoxy --no-daemon /etc/privoxy/config
