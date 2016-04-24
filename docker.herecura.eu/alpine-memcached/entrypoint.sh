#!/bin/sh

/container/user-setup.sh

memusage=64
maxconn=1024

if [[ ! -z "$MEMUSAGE" ]]; then
    memusage=$MEMUSAGE
fi

if [[ ! -z "$MAXCONN" ]]; then
    maxconn=$MAXCONN
fi

if [[ "memcached" != "$1" ]]; then
    su memcached -s /bin/sh -c "$@"
else
    memcached -u memcached -p 11211 -U 11211 -m $memusage -c $maxconn
fi
