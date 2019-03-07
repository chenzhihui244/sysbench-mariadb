#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb_path>"
	exit 1
}

mariadb_path=$1
mariadb_sock=${mariadb_path}/socket/mysql.sock

mysqladmin -uroot -S${mariadb_sock} ping || {
	echo "mariadb server not started"
	exit 1
}

mysql -uroot -S${mariadb_sock} -e "show databases;" | grep sbtest || {
	mysqladmin create sbtest -uroot -S ${mariadb_sock}

	mysql -uroot -S ${mariadb_sock} -e "update user set host='%' where user='root' and host='127.0.0.1';" mysql
	mysql -uroot -S ${mariadb_sock} -e "flush privileges;" mysql
}
