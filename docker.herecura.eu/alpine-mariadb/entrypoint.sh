#!/bin/sh

/container/user-setup.sh

if [[ "mysqld" != "$1" ]]; then
    su mariadb -s /bin/sh -c "$@"
else
    /container/mariadb-setup.sh
    exec "$@"
fi
