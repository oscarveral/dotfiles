#!/usr/bin/env bash

# Copy the kernel command line parameters and preset.

printf "\nCopying kernel cmdline and preset...\n\n"
cp "$MACHINE_PATH/files/etc/kernel/cmdline" /etc/kernel/cmdline || abort "copy cmdline"
cp "$MACHINE_PATH/files/etc/mkinitcpio.d/linux.preset" /etc/mkinitcpio.d/linux.preset || abort "copy linux.preset"

# Copy the mkinitcpio configuration file.

printf "Copying mkinitcpio configuration file...\n\n"
cp "$MACHINE_PATH/files/etc/mkinitcpio.conf" /etc/mkinitcpio.conf || abort "copy mkinitcpio.conf"

# Copy the crypttab files.

printf "Copying crypttab files...\n\n"
cp "$MACHINE_PATH/files/etc/crypttab" /etc/crypttab || abort "copy crypttab"
cp "$MACHINE_PATH/files/etc/crypttab.initramfs" /etc/crypttab.initramfs || abort "copy crypttab.initramfs"

# Generate the unified kernel image.

printf "Generating unified kernel image...\n\n"
if [ ! -d /boot/EFI/Linux ]; then
    mkdir -p /boot/EFI/Linux || abort "create /boot/EFI/Linux"
fi
mkinitcpio -p linux || abort "mkinitcpio"
