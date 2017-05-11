############################################################
# Dockerfile to run BlogDown
# Based on Alpine
############################################################

FROM alpine:3.5

MAINTAINER Jam Risser (jamrizzi)

ENV DEBUG=false

EXPOSE 8888

WORKDIR /app/

RUN apk add --no-cache tini \
    nginx \
    ca-certificates \
    php7-fpm \
    php7-json \
    php7-zlib \
    php7-xml \
    php7-pdo \
    php7-phar \
    php7-openssl \
    php7-pdo_mysql \
    php7-mysqli \
    php7-gd \
    php7-iconv \
    php7-mcrypt \
    python

COPY ./php7/ /app/

RUN mv /app/nginx.conf /etc/nginx/nginx.conf && \
    mkdir -p /etc/php/ && \
    mv /app/php-fpm.conf /etc/php/php-fpm.conf && \
    mkdir -p /tmp/nginx

ENTRYPOINT ["/sbin/tini", "--", "python", "/app/run.py"]
