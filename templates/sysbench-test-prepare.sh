#!/bin/bash

HOST={{ mariadb_server }}
MINPORT={{ mariadb_port_min }}
MAXPORT={{ mariadb_port_max }}
TABLE_SIZE={{ mariadb_table_size }}
TABLE_COUNT={{ mariadb_table_count }}
MAX_TIME={{ max_time }}
NUM_THREADS={{ threads_per_inst }}

PORT=${MINPORT}

while [ ${PORT} -le ${MAXPORT} ]; do
	mysql -h ${HOST} -P ${PORT} -u{{ mariadb_user }} -p{{ mariadb_pass }} -e "show databases;" | grep sbtest || {
		echo "database sbtest nonexist: HOST: $HOST, PORT: $PORT"
		exit 1
	}

	mysql -h ${HOST} -P ${PORT} -u{{ mariadb_user }} -p{{ mariadb_pass }} -e "use sbtest; show tables;" | grep sbtest1 ||
	sysbench --test=oltp \
		--mysql-host=${HOST} \
		--mysql-port=${PORT} \
		--mysql-db=sbtest \
		--mysql-user={{ mariadb_user }} \
		--mysql-password={{ mariadb_pass }} \
		--oltp-table-size=${TABLE_SIZE} \
		--oltp-tables-count=${TABLE_COUNT} \
		--oltp-read-only=on \
		--oltp-simple-ranges=1 \
		--max-requests=0 \
		--max-time=${MAX_TIME} \
		--report-interval=5 \
		--num-threads=${NUM_THREADS} \
		prepare

	let PORT++
done
