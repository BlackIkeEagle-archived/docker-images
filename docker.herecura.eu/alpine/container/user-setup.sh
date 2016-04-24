#!/bin/sh

user=root
uid=0
gid=0

if [[ -e /container/user-config.sh ]]; then
    source /container/user-config.sh
fi

if [[ "root" != "$user" ]]; then
    if [[ ! -z "$C_UID" ]]; then
        uid=$C_UID
    fi

    if [[ ! -z "$C_GID" ]]; then
        gid=$C_GID
    fi

    addgroup -g $gid -S $user
    adduser -u $uid -S -H -s /sbin/nologin -D -G $user $user
fi

