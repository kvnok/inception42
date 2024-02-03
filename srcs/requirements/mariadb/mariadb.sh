#!/bin/bash # This line tells the system this script should be executed with /bin/bash

# Check if the MariaDB initialization is complete
if [ ! -e "/var/lib/mysql/.done" ]; then
	# Initialize the MariaDB database
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	# Start the MariaDB server without networking
	/usr/sbin/mysqld --skip-networking &

	# Wait for MariaDB to be ready
	for i in {30..0}; do
		# Try to run a simple SQL query
		if echo 'SELECT 1' | mysql &> /dev/null; then
			break
		fi
		# Wait for 1 second before trying again
		sleep 1
	done

	# If MariaDB is not ready after 30 seconds, print an error message and exit
	if [ "$i" -eq 0 ]; then
		echo >&2 'MariaDB'
		exit 1
	fi

	# Create the database
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"
	# Create the user
	mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	# Grant all privileges on the database to the user
	mysql -u root -e "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';"
	# Reload the privilege tables
	mysql -u root -e "FLUSH PRIVILEGES;"
	# Set the password for the root user
	mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

	# Shutdown the MariaDB server
	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

	# Create a file to indicate that the MariaDB initialization is complete
	touch /var/lib/mysql/.done
fi

# Execute the command passed to the script
exec "$@"
