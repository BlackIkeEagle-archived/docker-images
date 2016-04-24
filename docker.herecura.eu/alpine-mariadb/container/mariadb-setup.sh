#!/bin/sh

if [[ ! -d "/run/mysqld" ]]; then
    mkdir /run/mysqld
fi
chown mariadb:mariadb -R /run/mysqld

if [[ ! -d "/var/lib/mysql/mysql" ]]; then
    mysql_install_db --user=mariadb --rpm

    chown mariadb:mariadb -R /var/lib/mysql

    # init mysql admin user
    mysqld --skip-networking &
    pid="$!"

    # countdown till we can use mysqld
    printf "MariaDB init ... "
    for count in $(seq 1 30); do
        if mysql -uroot -e 'SELECT 1' > /dev/null 2>&1; then
            break
        fi
        printf "$count "
        sleep 1
    done
    printf "\n"
    if [[ "$count" -ge 30 ]]; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    mysql -uroot <<-EOS
        CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';
        GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
        DROP DATABASE IF EXISTS test;
        FLUSH PRIVILEGES;
EOS

    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    echo 'MariaDB init done'
fi

