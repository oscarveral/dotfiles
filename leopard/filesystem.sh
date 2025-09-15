#!/usr/bin/env bash

# Unmount everything under /mnt before proceeding.

umount_all_under_mnt

# Format the root container.

mkfs.btrfs --label "linux" "$CONTAINER_LINUX" || abort "mkfs.btrfs"
printf "Formatted linux container: %s\n\n" "$CONTAINER_LINUX"
mount --mkdir -o noatime,compress=zstd "$CONTAINER_LINUX" /mnt || abort "mount linux"

# Format and mount the EFI partition.

mkfs.fat -F32 -n "efi" "$PARTITION_EFI" || abort "mkfs.fat efi"
printf "Formatted EFI partition: %s\n\n" "$PARTITION_EFI"
mount --mkdir "$PARTITION_EFI" /mnt/boot || abort "mount efi"

# Format the swap container.

mkswap --label "swap" "$CONTAINER_SWAP" || abort "mkswap"
printf "Formatted swap container: %s\n\n" "$CONTAINER_SWAP"
swapon "$CONTAINER_SWAP" || abort "swapon"

# Subvolume creation.

btrfs subvolume create /mnt/root || abort "create subvol root"
btrfs subvolume create /mnt/home || abort "create subvol home"
btrfs subvolume create /mnt/snapshot || abort "create subvol snapshot"
btrfs subvolume create /mnt/log || abort "create subvol log"
btrfs subvolume create /mnt/pacman || abort "create subvol pacman"

umount_all_under_mnt

# Mount subvolumes.

mount -o noatime,compress=zstd,subvol=root "$CONTAINER_LINUX" /mnt || abort "mount subvol root"
mount --mkdir -o noatime,compress=zstd,subvol=home "$CONTAINER_LINUX" /mnt/home || abort "mount subvol home"
mount --mkdir -o noatime,compress=zstd,subvol=log "$CONTAINER_LINUX" /mnt/var/log || abort "mount subvol log"
mount --mkdir -o noatime,compress=zstd,subvol=pacman "$CONTAINER_LINUX" /mnt/var/cache/pacman || abort "mount subvol pacman"
mount --mkdir "$PARTITION_EFI" /mnt/boot || abort "mount efi"
