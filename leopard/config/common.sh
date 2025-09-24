#!/usr/bin/env bash

set -e

# Common variables.

DOTFILES_LOCAL_PATH="/root/dotfiles"
MACHINE="leopard"
MACHINE_PATH="$DOTFILES_LOCAL_PATH/$MACHINE"
CHROOT_SCRIPTS_PATH="$MACHINE_PATH/config"

# Load error handling script.

source "$CHROOT_SCRIPTS_PATH/error.sh"

# Load execution scripts.

source "$CHROOT_SCRIPTS_PATH/ntp.sh"
source "$CHROOT_SCRIPTS_PATH/hostname.sh"