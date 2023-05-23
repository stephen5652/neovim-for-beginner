#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source $CURRENT_DIR/installTerminal.sh
source $CURRENT_DIR/installJava.sh
source $CURRENT_DIR/installZsh.sh
source $CURRENT_DIR/home_brew_tools.sh
