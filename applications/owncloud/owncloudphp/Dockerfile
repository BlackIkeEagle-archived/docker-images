FROM docker.herecura.eu/alpine-php-fpm
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN apk add --update php-ctype php-curl php-dom php-gd php-iconv php-json php-ldap php-openssl php-pdo php-pdo_mysql php-pear php-posix php-xmlreader php-zip php-zlib \
    && rm -rf /var/cache/apk/*

