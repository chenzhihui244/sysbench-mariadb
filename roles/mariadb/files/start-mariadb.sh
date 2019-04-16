#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <mariadb path>"
	exit 1
}

cpu_affinity_prefix=""
[ -n $2 ] && {
	mariadb_cpu=$2
	cpu_affinity_prefix="numactl -C ${2} --localalloc"
}

mariadb_path=$1
mariadb_conf=${mariadb_path}/etc/my.cnf

[ -f ${mariadb_path}/pid/mariadb.pid ] || {

	mysql_install_db --basedir=/usr --datadir=${mariadb_path}/data --user=mysql

	${cpu_affinity_prefix} mysqld_safe --defaults-file=${mariadb_conf} &

	# sleep before exit, so mariadb server will not be killed after exit
	sleep 10
}
