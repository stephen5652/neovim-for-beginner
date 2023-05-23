#!/usr/bin/env bash

home_dir=$HOME
bash_profile_path=${HOME}/.bash_profile

install_home=$(
	cd $(dirname $0)
	pwd
)

safe_link() {
	source=$1
	des=$2

	des_dir=${des%/*}
	if [[ ! -d ${des_dir} ]]; then
		echo -e "should make path:${des_dir}"
		mkdir -p ${des_dir}
	fi

	if [[ -d ${des} || -f ${des} ]]; then
		if [[ -L ${des} ]]; then # is link
			echo -e "Warning: link is existed, we remove it:${des}"
			rm ${des}
		else

			time=$(date "+%Y%m%d-%H%M%S")
			echo -e "Warning: file existed ${des} , rename it to ${des}_bak_${time}"
			mv ${des} ${des}_${time}
		fi
	fi

	echo -e "ln -s ${source} ${des}"
	ln -s ${source} ${des}
}
