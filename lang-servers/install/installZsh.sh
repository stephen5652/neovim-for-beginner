#!/usr/bin/env bash
#

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source $CURRENT_DIR/para.sh

install_zsh() {
	echo -e "\nStart install zsh"

	echo -e "\nAfter install finish, you should run config.sh"

	#install pk10

	brew install zsh

	if [[ -d ${home_dir}/.oh-my-zsh ]]; then
		rm -rf ${home_dir}/.oh-my-zsh
	fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

main_zsh() {
	install_zsh
}

main_zsh
