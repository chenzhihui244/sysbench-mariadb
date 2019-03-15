#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb_path>"
	exit 1
}

mariadb_path=$1
mariadb_sock=${mariadb_path}/socket/mysql.sock
mariadb_user=${2:-root}
mariadb_pass=${3:-123456}

mysqladmin -u${mariadb_user} -p${mariadb_pass} -S ${mariadb_path}/socket/mysql.sock shutdown
