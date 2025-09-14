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
    gum 

# Generate the fstab file.

genfstab -U /mnt >> /mnt/etc/fstab