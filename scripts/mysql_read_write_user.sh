#!/bin/bash

# MySQL root username and password
MYSQL_ROOT_USER="root"
MYSQL_ROOT_PASSWORD="your_root_password"

# MySQL database name
DATABASE_NAME="your_database_name"

# Read-only user credentials
READ_USER="readuser"
READ_USER_PASSWORD="readuser_password"

# Write user credentials
WRITE_USER="writeuser"
WRITE_USER_PASSWORD="writeuser_password"

# MySQL commands to create users and grant privileges
MYSQL_COMMANDS=$(cat <<EOF
CREATE USER '${READ_USER}'@'%' IDENTIFIED BY '${READ_USER_PASSWORD}';
CREATE USER '${WRITE_USER}'@'%' IDENTIFIED BY '${WRITE_USER_PASSWORD}';
GRANT SELECT ON ${DATABASE_NAME}.* TO '${READ_USER}'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${DATABASE_NAME}.* TO '${WRITE_USER}'@'%';
FLUSH PRIVILEGES;
EOF
)

# Execute MySQL commands using root credentials
mysql -u"${MYSQL_ROOT_USER}" -p"${MYSQL_ROOT_PASSWORD}" -e"${MYSQL_COMMANDS}"

