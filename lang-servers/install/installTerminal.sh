#!/usr/bin/env bash
#

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source $CURRENT_DIR/para.sh

link_nvim_config() {
	echo -e "\nStart link nvim config"
	nvim_name=${home_dir}/.config/nvim
	real_nvim_config=$install_home/../nvim
	safe_link ${real_nvim_config} ${nvim_name}
}

install_tool() {
	echo -e "\nstarging homebrew install tools\n"

	brew install wget nodejs yarn

	brew link --overwrite node

	npm config set registry http://registry.npmmirror.com
	yarn config set registry http://registry.npmmirror.com

	echo -e "\nhomebrew install tools finish"
}

install_plugin_implementations() {
	echo -e "Start install nvim plugin implentations\n"
	brew install lazygit

	brew install ripgrep # plugins for telescope, nvim command: checkhealth telescope
	brew install fd      # plugins for telescope, nvim command: checkhealth telescope

	brew install swiftlint        # enable  null-ls swiftlint
	brew install astyle --verbose # enable null-ls astyle

	gem install neovim # enable ruby language

	npm install -g vls # enable vue language
	echo -e "Finish install nvim plugins implementations\n"
}

install_dap_debug() {
	echo -e "\nbeging install dap debug\n"

	# codelldb
	echo "install codelldb"
	rm -rf ${home_dir}/.local/share/nvim/data/debug/tools
	mkdir -pv ${home_dir}/.local/share/nvim/data/debug/tools
	wget https://github.com/vadimcn/codelldb/releases/download/v1.9.0/codelldb-x86_64-darwin.vsix -P ${home_dir}/Downloads
	unzip -d ${home_dir}/.local/share/nvim/data/debug/tools/ ${home_dir}/Downloads/codelldb-x86_64-darwin.vsix

	echo -e "\ninstall codelldb finish\n"
}

install_tmux() {
	echo -e "\nbeging install tmux"

	brew install tmux

	echo -e "\nbeging link tmux config"
	source=$install_home/../tmux/tmux.conf
	des=${home_dir}/.tmux.conf
	safe_link ${source} ${des}
}

install_yabai() {
	echo -e "\nBeging install yabai"

	source=$install_home/../yabai/yabairc
	dest=${home_dir}/.config/yabai/yabairc
	safe_link ${source} ${dest}

	brew install koekeishiya/formulae/yabai --HEAD
	codesign -fs 'yabai-cert' $(which yabai)
	yabai --start-service

}

install_skhd() {
	echo -e "\nStart install shkd"

	source=$install_home/../skhd/skhdrc
	dest=${home_dir}/.config/skhd/skhdrc
	safe_link ${source} ${dest}

	brew install koekeishiya/formulae/skhd
	skhd --stop-service
	skhd --start-service
}

install_lazygit() {
	echo -e "\nStart install lazygit & tig"
	brew install lazygit
	brew install tig

	source=$install_home/../tig/tigrc
	dest=${home_dir}/.tigrc
	safe_link ${source} ${dest}
}

install_brew() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	rm ${HOME}/.zprofile
	(
		echo
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
	) >>/Users/imac24inch/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

main_term() {
	safe_link $install_home/../zsh/bash_profile $home_dir/.bash_profile
	install_brew

	install_tmux

	install_yabai

	install_skhd

	install_lazygit

	link_nvim_config
	install_tool
	install_plugin_implementations
	install_dap_debug
}

main_term
