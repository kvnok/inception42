#!/bin/bash

if [ ! -f ./wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root
    wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    wp user create $WP_NORMAL_USER $WP_NORMAL_USER_EMAIL --user_pass=$WP_NORMAL_USER_PASSWORD --role=author --allow-root
fi
    #wp theme install twentynineteen --activate --allow-root # Install and activate the 'twentynineteen' theme
	#wp plugin update --all --allow-root # Update all WordPress plugins

exec "$@"

