#!/usr/bin/env bash

# Copy locale configuration file.

cp "$MACHINE_PATH/files/etc/locale.gen" /etc/locale.gen || abort "copy locale.gen"

# Generate locales.

locale-gen || abort "generate locales"
printf "\n"

# Copy the locale configuration file.

cp "$MACHINE_PATH/files/etc/locale.conf" /etc/locale.conf || abort "copy locale.conf"

# Set keymap.

cp "$MACHINE_PATH/files/etc/vconsole.conf" /etc/vconsole.conf || abort "copy vconsole.conf"