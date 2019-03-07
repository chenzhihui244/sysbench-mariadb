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
	sysbench --test=oltp \
		--mysql-host=${HOST} \
		--mysql-port=${PORT} \
		--mysql-db=sbtest \
		--mysql-user=root \
		--oltp-table-size=${TABLE_SIZE} \
		--oltp-tables-count=${TABLE_COUNT} \
		--oltop-read-only=on \
		--oltp-simple-ranges=1 \
		--oltp-point-selects=0 \
		--oltp-sum-ranges=0 \
		--oltp-order-ranges=0 \
		--oltp-distinct-ranges=0 \
		--max-requests=0 \
		--max-time=${MAX_TIME} \
		--report-interval=5 \
		--num-threads=${NUM_THREADS} \
		run > ${PORT}.txt 2>&1 &

	sleep 1

	let PORT++
done
