#!/bin/sh

/container/user-setup.sh

if [[ "nginx" != "$1" ]]; then
    su nginx -s /bin/sh -c "$@"
else
    exec "$@"
fi
