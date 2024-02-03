FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

EXPOSE 3306

COPY mariadb.sh /mariadb.sh
RUN chmod +x /mariadb.sh

ENTRYPOINT ["/bin/bash", "/mariadb.sh"]

CMD ["/usr/sbin/mysqld"]
