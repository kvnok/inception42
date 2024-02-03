FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get -y install php7.4 php-fpm php-cli php-mysql php-mbstring php-xml mariadb-client curl

RUN mkdir /run/php
RUN mkdir -p /var/www/html/
RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/bin/bash", "/wordpress.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]
