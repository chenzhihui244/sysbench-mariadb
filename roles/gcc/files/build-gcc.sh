#!/bin/bash

[ -z $1 ] && exit 1
[ -z $2 ] && exit 1

gcc_path=$1
gcc_src_pkg=$2
gcc_src_dir=${gcc_src_pkg%\.*}
gcc_src_dir=${gcc_src_dir%\.*}
gcc_suffix=`echo $gcc_src_dir | cut -d- -f 2 | cut -d. -f 1`
gcc_suffix=-$gcc_suffix

[ -x ${gcc_path}/bin/gcc${gcc_suffix} ] && {
	echo "${gcc_path}/bin/gcc${gcc_suffix} already exist"
	exit
}

cd ${gcc_path}
[ -d ${gcc_src_dir} ] || {
	tar xf ${gcc_src_pkg}
	cd ${gcc_src_dir}
	./contrib/download_prerequisites
	cd ..
}

rm -rf build-gcc && mkdir build-gcc && cd build-gcc
../${gcc_src_dir}/configure \
	--prefix=/${gcc_path} \
	--enable-bootstrap \
	--enable-shared \
	--enable-threads=posix \
	--enable-checking=release \
	--with-system-zlib \
	--enable-__cxa_atexit \
	--disable-libunwind-exceptions \
	--enable-gnu-unique-object \
	--enable-linker-build-id \
	--with-linker-hash-style=gnu \
	--enable-languages=c,c++,fortran,lto \
	--enable-plugin \
	--enable-initfini-array \
	--disable-libgcj \
	--enable-gnu-indirect-function \
	--build=aarch64-redhat-linux \
	--program-suffix=${gcc_suffix}

make -j`nproc` && make install
