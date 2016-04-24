FROM docker.herecura.eu/alpine:stable
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN apk add --update php-fpm php-mcrypt php-sqlite3 \
    && rm -rf /var/cache/apk/*

RUN sed -e 's#^\(error_log\).*#\1 = /dev/stderr#' \
        -e 's#^;\(access.log\).*#\1 = /dev/stdout#' \
        -e 's#^;\(daemonize\).*#\1 = no#' \
        -e 's#^\(user\).*#\1 = php#' \
        -e 's#^\(group\).*#\1 = php#' \
        -e 's#^\(listen\).*#\1 = 0.0.0.0:9000#' \
        -e 's#^;\(catch_workers_output\).*#\1 = yes#' \
        -e 's#^;\(clear_env\).*#\1 = no#' \
        -i /etc/php/php-fpm.conf

RUN mkdir -p /var/www

COPY ./container /container
ADD ./entrypoint.sh /entrypoint.sh

EXPOSE 9000

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
