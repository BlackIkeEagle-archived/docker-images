FROM docker.herecura.eu/alpine:stable
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN apk add --update nginx \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/nginx/sites-enabled

ADD ./config/nginx.conf /etc/nginx/nginx.conf
ADD ./config/00-default.conf /etc/nginx/sites-enabled/00-default.conf
ADD ./default/index.html /var/www/localhost/htdocs/index.html
ADD ./entrypoint.sh /entrypoint.sh

COPY ./container /container

RUN /container/user-cleanup.sh

RUN chmod u=rwX,og=rX -R /var/www

ONBUILD RUN rm /etc/nginx/sites-enabled/00-default.conf
ONBUILD ADD ./sites/*.conf /etc/nginx/sites-enabled/

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]
