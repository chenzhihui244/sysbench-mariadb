#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb_path>"
	exit 1
}

mariadb_path=$1
mariadb_sock=${mariadb_path}/socket/mysql.sock
mariadb_user=${2:-root}
mariadb_pass=${3:-123456}

mysqladmin -u${mariadb_user} -S${mariadb_sock} ping 2>&1 | grep failed && {
	echo "mariadb server not started"
	exit 1
}

# set passwd
mysqladmin -u${mariadb_user} -S ${mariadb_sock} password "${mariadb_pass}"

mysql -u${mariadb_user} -p${mariadb_pass} -S${mariadb_sock} -e "show databases;" | grep -q sbtest || {
	mysqladmin create sbtest -u${mariadb_user} -p${mariadb_pass} -S ${mariadb_sock}

	mysql -u${mariadb_user} -p${mariadb_pass} -S ${mariadb_sock} -e "grant all privileges on *.* to ${mariadb_user}@'%' identified by '${mariadb_pass}' with grant option;" mysql || exit 1
	#mysql -u${mariadb_user} -p${mariadb_pass} -S ${mariadb_sock} -e "grant all privileges on *.* to ${mariadb_user}@'%' identified by '123456' with grant option;" mysql || exit 1
	mysql -u${mariadb_user} -p${mariadb_pass} -S ${mariadb_sock} -e "flush privileges;" mysql || exit 1
}
