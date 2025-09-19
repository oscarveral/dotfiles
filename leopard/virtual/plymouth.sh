#!/usr/bin/env bash

# Copy the Plymouth configuration file and theme.

cp "$MACHINE_PATH/files/etc/plymouth/plymouthd.conf" /etc/plymouth/plymouthd.conf || abort "copy plymouth configuration file"
cp -r "$MACHINE_PATH/files/usr/share/plymouth/themes/dna/" /usr/share/plymouth/themes/ || abort "copy plymouth theme"