FROM docker.herecura.eu/alpine:stable
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN apk add --update memcached \
    && rm -rf /var/cache/apk/*

COPY ./container /container
ADD ./entrypoint.sh /entrypoint.sh

RUN /container/user-cleanup.sh

EXPOSE 11211

ENTRYPOINT ["/entrypoint.sh"]
CMD ["memcached"]
