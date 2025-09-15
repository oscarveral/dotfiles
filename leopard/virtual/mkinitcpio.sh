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

# Create the EFI boot entry.

printf "Creating EFI boot entry...\n\n"

# Remove previous EFI boot entries named 'Arch Linux'

printf "Removing existing 'Arch Linux' EFI boot entries (if any)\n"
efibootmgr | grep -i "Arch Linux" | while read -r line; do
    # Extract the Boot number (e.g. Boot0001*) and strip non-hex characters
    num=$(printf '%s' "$line" | awk '{print $1}' | sed 's/Boot//;s/[^0-9A-Fa-f]//g')
    if [ -n "$num" ]; then
        efibootmgr -b "$num" -B || true
    fi
done

# Add the corresponding EFI system partition disk path as a new boot entry

EFI_PARTITION_SOURCE=$(findmnt -no SOURCE /boot)
if [ -n "$EFI_PARTITION_SOURCE" ]; then
    echo "Creating new EFI boot entry on disk: $EFI_PARTITION_SOURCE"
    efibootmgr --create --disk "$EFI_PARTITION_SOURCE" --part 1 --loader '\\EFI\\Linux\\arch-linux.efi' --label "Arch Linux" --unicode || true
else
    abort "findmnt /boot"
fi