#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <jemalloc_path> <jemalloc_src_pkg>"
	exit 1;
}

[ -f /usr/local/lib/libjemalloc.so ] && exit

jemalloc_path=$1
jemalloc_src_pkg=$2

jemalloc_src_dir=${jemalloc_src_pkg%\.*}
jemalloc_src_dir=${jemalloc_src_dir%\.*}

cd ${jemalloc_path}

tar xf ${jemalloc_src_pkg}
cd ${jemalloc_src_dir}

./configure && make && make install

echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
ldconfig
