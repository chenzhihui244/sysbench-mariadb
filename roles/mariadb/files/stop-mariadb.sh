#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb_path>"
	exit 1
}

mariadb_path=$1

/usr/bin/mysqladmin -uroot -S ${mariadb_path}/socket/mysql.sock shutdown
