# Use the official Debian image as the base
FROM debian:bullseye

# Update the package lists for upgrades for packages that need upgrading, as well as new packages that have just come to the repositories
RUN apt-get update -y && apt-get upgrade -y

# Install Nginx and OpenSSL
RUN apt-get -y install nginx openssl

# Generate a new self-signed SSL certificate and private key with OpenSSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=42/OU=codam/CN=localhost"

# Copy the Nginx configuration file from the local system to the Docker image
COPY default /etc/nginx/sites-available/default

# Set the command to start Nginx when the Docker container starts
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
