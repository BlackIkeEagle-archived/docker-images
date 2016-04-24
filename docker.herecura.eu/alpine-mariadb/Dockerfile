FROM docker.herecura.eu/alpine:stable
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN apk add --update mariadb mariadb-client \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/mysql/conf.d \
    && echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf

ADD ./docker.cnf /etc/mysql/conf.d/docker.cnf
COPY ./container /container
ADD ./entrypoint.sh /entrypoint.sh

RUN /container/user-cleanup.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
