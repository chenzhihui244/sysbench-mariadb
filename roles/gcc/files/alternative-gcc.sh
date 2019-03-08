#!/bin/bash

[ -z $1 ] && exit 1
[ -z $2 ] && exit 1

gcc_path=$1
gcc_src_pkg=$2

alternative_ver() {
	local name=$1

	[ -L /usr/bin/${name} ] && {
		return
	}

	local old_suf=`${name} -v 2>&1 | grep version | cut -d\  -f 3 | cut -d. -f 1`
	local old_suffix=-$old_suf
	local new_suf=`echo $gcc_src_pkg | cut -d- -f 2 | cut -d. -f 1`
	local new_suffix=-$new_suf
	local link_file=/usr/bin/${name}

	echo $old_suffix $new_suffix

	[ -f ${link_file}${old_suffix} ] || {
		mv ${link_file} ${link_file}${old_suffix}
	}

	alternatives --install ${link_file} ${name} ${link_file}${old_suffix} ${old_suf}
	alternatives --install ${link_file} ${name} ${gcc_path}/bin/${name}${new_suffix} ${new_suf}
}

alternative_ver gcc
alternative_ver g++
alternative_ver gfortran
alternative_ver c++
alternative_ver cpp

grep -q "$gcc_path}" /etc/profile || {
	cat << EOF >> /etc/profile 
LD_LIBRARY_PATH=${gcc_path}/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
EOF
}
