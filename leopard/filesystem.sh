#!/usr/bin/env bash

# Function to unmount everything under /mnt.

umount_all_under_mnt() {
	local targets
	targets=$(findmnt -rn -o TARGET | grep '^/mnt' | sort -r)
	for t in $targets; do
		echo "Unmounting $t"
		umount "$t"
	done
}

# Unmount everything under /mnt before proceeding.

umount_all_under_mnt

# Format the root container.

mkfs.btrfs --label "linux" "$CONTAINER_LINUX" || abort "mkfs.btrfs"
printf "Formatted linux container: %s\n\n" "$CONTAINER_LINUX"
mount --mkdir "$CONTAINER_LINUX" /mnt || abort "mount linux"

# Format and mount the EFI partition.

mkfs.fat -F32 -n "efi" "$PARTITION_EFI" || abort "mkfs.fat efi"
printf "Formatted EFI partition: %s\n\n" "$PARTITION_EFI"
mount --mkdir "$PARTITION_EFI" /mnt/boot || abort "mount efi"

# Format the swap container.

mkswap --label "swap" "$CONTAINER_SWAP" || abort "mkswap"
printf "Formatted swap container: %s\n\n" "$CONTAINER_SWAP"
swapon "$CONTAINER_SWAP" || abort "swapon"