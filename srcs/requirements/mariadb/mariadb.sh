#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  
  /usr/sbin/mysqld --skip-networking &

  for i in {30..0}; do
      if echo 'SELECT 1' | mysql &> /dev/null; then
          break
      fi
      sleep 1
  done

  if [ "$i" -eq 0 ]; then
      echo >&2 'MariaDB'
      exit 1
  fi

  mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"
  mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -u root -e "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';"
  mysql -u root -e "FLUSH PRIVILEGES;"
  mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

  mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

  touch /var/lib/mysql/.init_complete
fi

exec "$@"
