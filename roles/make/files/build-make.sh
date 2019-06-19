#!/bin/sh

#!/bin/sh

[ -z $1 ] && exit 1
[ -z $2 ] && exit 1

make_path=$1
make_src_pkg=$2
make_src_dir=${make_src_pkg%\.*}
make_src_dir=${make_src_dir%\.*}

cd ${make_path}
[ -d ${make_src_dir} ] || {
	tar xf ${make_src_pkg}
}

rm -rf build-make && mkdir build-make && cd build-make

../${make_src_dir}/configure \
	--prefix=${make_path}

make -j`nproc` && make install

ln -sf ${make_path}/bin/make ${make_path}/bin/gmake
