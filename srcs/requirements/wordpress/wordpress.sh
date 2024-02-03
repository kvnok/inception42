# This line tells the system this script should be executed with /bin/bash
#!/bin/bash

# Check if the WordPress configuration file exists
if [ ! -f ./wp-config.php ]; then
	# Download the WordPress core files
	wp core download --allow-root

	# Create the WordPress configuration file with the provided database credentials and host
	wp config create --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root

	# Install WordPress with the provided site information and admin credentials
	wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

	# Create a new WordPress user with the provided credentials and role
	wp user create $WP_NORMAL_USER $WP_NORMAL_USER_EMAIL --user_pass=$WP_NORMAL_USER_PASSWORD --role=author --allow-root
fi

# Execute the command passed to the script
exec "$@"
