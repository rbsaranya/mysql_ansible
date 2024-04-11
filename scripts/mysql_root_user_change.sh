#!/bin/bash
set -xv
# Remote server details
ssh_host="172.20.72.197"
ssh_user=""
MYSQL_ROOT_PASSWORD=""

MYSQL_ERROR_LOG="/mnt/vol2/mysql/data/mysql-error.log"

MYSQL_TEMP_PASSWORD=$(ssh "$ssh_user@$ssh_host" "sudo cat /mnt/vol2/mysql/data/mysql-error.log|grep 'temporary password'| awk '{print $NF}'")

ssh "$ssh_user@$ssh_host" "mysql -u root -p'$MYSQL_TEMP_PASSWORD' -e \"ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';\""

