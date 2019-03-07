#!/bin/bash

[ -z $1 ] && exit 1
[ -x /usr/local/bin/sysbench ] || {
	cd $1
	./autogen.sh
	./configure
	make && make install
}
