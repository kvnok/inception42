FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get -y install nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=42/OU=codam/CN=localhost"

COPY default /etc/nginx/sites-available/default

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
