#!/bin/sh

[ -z $1 ] && exit 1
[ -z $2 ] && exit 1

glibc_path=$1
make_path=${glibc_path}/../make
gcc_path=${glibc_path}/../gcc
glibc_src_pkg=$2
glibc_src_dir=${glibc_src_pkg%\.*}
glibc_src_dir=${glibc_src_dir%\.*}

cd ${glibc_path}
[ -d ${glibc_src_dir} ] || {
	tar xf ${glibc_src_pkg}
}

rm -rf build-glibc && mkdir build-glibc && cd build-glibc

export PATH=${make_path}/bin:${gcc_path}/bin:$PATH
export LD_LIBRARY_PATH=${gcc_path}/lib64

../${glibc_src_dir}/configure \
	--prefix=/usr

make -j`nproc` && make install DESTDIR=${glibc_path}
