#!/bin/bash

# SSH server details
SSH_HOST="host_ip"
SSH_USER="user_name"
MYSQL_USER="root"
MYSQL_PASSWORD="password"
READ_USER="readonly_user"
READ_USER_PASSWORD="password"


ssh $SSH_USER@$SSH_HOST "mysql -u$MYSQL_USER -p'$MYSQL_PASSWORD' -e "CREATE USER '$READ_USER'@'localhost' IDENTIFIED BY '$READ_USER_PASSWORD'; GRANT SELECT ON *.* TO '$READ_USER'@'localhost'; FLUSH PRIVILEGES;\""
