#!/usr/bin/env bash

printf "\nStarting leopard installation...\n\n"

# Exit on any error.

set -e

# Source install scripts.
source "$MACHINE_PATH/utils.sh"
source "$MACHINE_PATH/guards.sh"
source "$MACHINE_PATH/disk.sh"
source "$MACHINE_PATH/encryption.sh"
source "$MACHINE_PATH/filesystem.sh"
source "$MACHINE_PATH/base.sh"
source "$MACHINE_PATH/chroot.sh"