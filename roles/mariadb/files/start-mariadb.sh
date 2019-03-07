#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb path>"
	exit 1
}

mariadb_path=$1
mariadb_conf_path=${mariadb_path}/etc/my.cnf

[ -f ${mariadb_path}/pid/mariadb ] || {

	mysql_install_db --basedir=/usr --datadir=${mariadb_path}/data --user=mysql

	mysqld_safe --defaults-file=${mariadb_conf_path} &

	# sleep before exit, so mariadb server will not be killed after exit
	sleep 10
}
