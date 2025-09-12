#!/usr/bin/env bash

printf "\nStarting leopard installation...\n\n"

# Exit on any error.

set -e

# Source preparation scripts.
source "$MACHINE_PATH/guards.sh"
source "$MACHINE_PATH/disk.sh"