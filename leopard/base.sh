#!/usr/bin/env bash

# Install essential packages for the installation.

pacstrap -K /mnt \
    base \
    linux \
    linux-firmware \
    intel-ucode \
    btrfs-progs \
    dosfstools \
    helix \
    systemd-ukify \
    mkinitcpio \
    git \
    gum \
    efibootmgr || abort "pacstrap"

# Generate the fstab file.

printf "\n\nGenerating fstab file...\n\n"
genfstab -U /mnt
genfstab -U /mnt >> /mnt/etc/fstab