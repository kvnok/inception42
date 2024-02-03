# Install base image
FROM debian:bullseye

# Update and upgrade packages
RUN apt-get update -y && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install -y mariadb-server

# Copy custom configuration file
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create directory for MySQL runtime files
RUN mkdir -p /var/run/mysqld

# Set ownership of MySQL directories
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Expose port 3306 for MySQL connections
EXPOSE 3306

# Copy startup script
COPY mariadb.sh /mariadb.sh

# Set executable permissions for the startup script
RUN chmod +x /mariadb.sh

# Set the entrypoint for the container
ENTRYPOINT ["/bin/bash", "/mariadb.sh"]

# Start the MySQL server
CMD ["/usr/sbin/mysqld"]
