#!/usr/bin/env bash

# Copy hostname configuration file.

cp "$MACHINE_PATH/files/etc/hostname" /etc/hostname || abort "copy hostname"

# Show hostname.

printf "Hostname: %s\n\n" "$(cat /etc/hostname)"