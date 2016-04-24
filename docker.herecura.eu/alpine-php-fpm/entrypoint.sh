#!/bin/sh

/container/user-setup.sh

if [[ "php-fpm" != "$1" ]]; then
    su php -s /bin/sh -c "$@"
else
    exec "$@"
fi
