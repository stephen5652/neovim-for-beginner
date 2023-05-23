#!/usr/bin/env bash

install_brew_tools() {
	brew install z
	brew install ncdu
}

install_exec() {
	echo -e "\nStart install home brew tools"
	install_brew_tools
}

install_exec
