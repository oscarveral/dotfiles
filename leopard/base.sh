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
    efibootmgr \
    plymouth \
    nvidia-open || abort "pacstrap"

# Generate the fstab file.

printf "\n\nGenerating fstab file...\n\n"
genfstab -L /mnt
genfstab -L /mnt >> /mnt/etc/fstab