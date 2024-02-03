# Use the official Debian image as the base
FROM debian:bullseye

# Update the package lists for upgrades for packages that need upgrading, as well as new packages that have just come to the repositories
RUN apt-get update -y && apt-get upgrade -y

# Install PHP, PHP-FPM, PHP-CLI, PHP-MYSQL, PHP-MBSTRING, PHP-XML, MariaDB client, and curl
RUN apt-get -y install php7.4 php-fpm php-cli php-mysql php-mbstring php-xml mariadb-client curl

# Create a directory for PHP to run
RUN mkdir /run/php

# Create a directory for the website files
RUN mkdir -p /var/www/html/

# Change the owner of the website directory to www-data
RUN chown -R www-data:www-data /var/www/html

# Download the WP-CLI tool
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make the WP-CLI tool executable
RUN chmod +x wp-cli.phar

# Move the WP-CLI tool to a directory in the PATH
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM configuration file from the local system to the Docker image
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy the WordPress setup shell script from the local system to the Docker image
COPY wordpress.sh /wordpress.sh

# Make the WordPress setup shell script executable
RUN chmod +x /wordpress.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the working directory to the website directory
WORKDIR /var/www/html

# Set the entrypoint to the WordPress setup shell script
ENTRYPOINT ["/bin/bash", "/wordpress.sh"]

# Set the command to start PHP-FPM when the Docker container starts
CMD ["/usr/sbin/php-fpm7.4", "-F"]
