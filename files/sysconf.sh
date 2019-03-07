#!/bin/bash

sysconf_from_hjh {
	echo 6553600 > /proc/sys/fs/aio-max-nr
	echo 10 > /proc/sys/net/ipv4/tcp_fin_timeout
	echo 1024000 > /proc/sys/net/ipv4/tcp_max_syn_backlog
}
