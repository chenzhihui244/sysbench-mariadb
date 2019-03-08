#!/bin/bash

[ -z $1 ] && {
	echo "usage: $0 <percona_path> <percona_src_pkg>"
	exit 1;
}

percona_path=$1
percona_src_pkg=$2

percona_src_dir=${percona_src_pkg%\.*}
percona_src_dir=${percona_src_dir%\.*}

[ -x ${percona_path}/bin/mysqld ] && exit

cd ${percona_path}

rm -rf ${percona_src_dir}
tar xf ${percona_src_pkg} && cd ${percona_src_dir}

	#-DZLIB_LIBRARY:FILEPATH=/usr/local/zlib/lib/ \
	#-DZLIB_INCLUDE_DIR:PATH=/usr/local/zlib/include/ \
	#-DWITH_SSL:STRING=bundled \
	#-DWITH_ZLIB:STRING=bundled \
cmake . -DCMAKE_INSTALL_PREFIX=${percona_path} \
	-DMYSQL_UNIX_ADDR=/run/mysql.sock \
	-DMYSQL_DATADIR=${percona_path}/data/mysql/ \
	-DSYSCONFDIR=${percona_path}/etc \
	-DMYSQL_USER=mysql \
	-DMYSQL_TCP_PORT=3306 \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	-DWITH_MEMORY_STORAGE_ENGINE=1 \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DENABLED_LOCAL_INFILE=1 \
	-DWITH_DEBUG=0 \
	-DDEFAULT_CHARSET=utf8 \
	-DDEFAULT_COLLATION=utf8_general_ci \
	-DWITH_EXTRA_CHARSETS=all \
	-DMYSQL_MAINTAINER_MODE=0 \
	-DWITH_EDITLINE=bundled \
	-DCMAKE_EXE_LINKER_FLAGS="-ljemalloc" \
	-DENABLE_DOWNLOADS=1 \
	-DBUILD_CONFIG=mysql_release \
	-DWITH_BOOST=${percona_path}/boost

make && make install
