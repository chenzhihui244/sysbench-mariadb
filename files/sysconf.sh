#!/bin/bash

sysconf_from_hjh {
	echo 6553600 > /proc/sys/fs/aio-max-nr
	echo 6553600 > /proc/sys/fs/aio-max-nr
	echo 10 > /proc/sys/net/ipv4/tcp_fin_timeout
	echo 10 > /proc/sys/net/ipv4/tcp_fin_timeout
	echo 1024000 > /proc/sys/net/ipv4/tcp_max_syn_backlog
	echo 2621440 > /proc/sys/net/ipv4/tcp_max_syn_backlog

	echo 1 > /proc/sys/net/ipv4/tcp_timestamps
	echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
	echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
	echo 2048 65000 > /proc/sys/net/ipv4/ip_local_port_range
	echo 2621440 > /proc/sys/net/core/somaxconn
	echo 2621440 > /proc/sys/net/core/netdev_max_backlog
	echo 1 > /proc/sys/net/netfilter/nf_conntrack_tcp_timeout_time_wait
	echo 2621440 > /proc/sys/net/netfilter/nf_conntrack_max
}
