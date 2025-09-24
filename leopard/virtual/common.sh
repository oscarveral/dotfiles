#!/usr/bin/env bash

set -e

# Common variables.

DOTFILES_LOCAL_PATH="/root/dotfiles"
MACHINE="leopard"
MACHINE_PATH="$DOTFILES_LOCAL_PATH/$MACHINE"
CHROOT_SCRIPTS_PATH="$MACHINE_PATH/virtual"

# Load error handling script.

source "$CHROOT_SCRIPTS_PATH/error.sh"

# Load execution scripts.

source "$CHROOT_SCRIPTS_PATH/timezone.sh"
source "$CHROOT_SCRIPTS_PATH/locale.sh"
source "$CHROOT_SCRIPTS_PATH/network.sh"
source "$CHROOT_SCRIPTS_PATH/plymouth.sh"
source "$CHROOT_SCRIPTS_PATH/mkinitcpio.sh"
source "$CHROOT_SCRIPTS_PATH/root.sh"
source "$CHROOT_SCRIPTS_PATH/efi.sh"