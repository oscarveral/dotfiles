#!/usr/bin/env bash

set -e

# Common variables.

DOTFILES_LOCAL_PATH="/root/dotfiles"
MACHINE="leopard"
MACHINE_PATH="$DOTFILES_LOCAL_PATH/$MACHINE"
SCRIPTS_PATH="$MACHINE_PATH/config"

# Load error handling script.

source "$SCRIPTS_PATH/error.sh"

# Load execution scripts.

source "$SCRIPTS_PATH/ntp.sh"
source "$SCRIPTS_PATH/hostname.sh"
source "$SCRIPTS_PATH/packages.sh"
source "$SCRIPTS_PATH/ly.sh"
source "$SCRIPTS_PATH/user.sh"
