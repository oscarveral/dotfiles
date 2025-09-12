#!/usr/bin/env bash

# Select disk to partition.

DISKS_WITH_SIZE=$(lsblk -dn -o NAME,SIZE,TYPE | awk '$3=="disk" {print $1, $2}')
SELECTED_DISK_LINE=$(printf "%s\n" "$DISKS_WITH_SIZE" | gum choose)
if [ -z "$SELECTED_DISK_LINE" ]; then
    printf "No disk selected. Exiting.\n"
    exit 1
fi
SELECTED_DISK="${SELECTED_DISK_LINE%% *}"
DISK_PATH="/dev/$SELECTED_DISK"
printf "Selected disk: %s (%s)\n" "$DISK_PATH" "${SELECTED_DISK_LINE#* }"
gum confirm "Erase all data on $DISK_PATH and create new GPT partitions?" || exit 1

# Partition disk on GPT scheme.

EFI_PART_LABEL="efi"
SWAP_PART_LABEL="swap"
LINUX_PART_LABEL="linux"
parted --script "$DISK_PATH" -- \
    mklabel gpt \
    mkpart primary fat32 1MiB 1GiB \
    set 1 boot on \
    set 1 esp on \
    name 1 "$EFI_PART_LABEL" \
    mkpart primary linux-swap 1GiB 33GiB \
    set 2 swap on \
    name 2 "$SWAP_PART_LABEL" \
    mkpart primary btrfs 33GiB 100% \
    name 3 "$LINUX_PART_LABEL" \
    print

# Export disk and partition variables.
DISK="$DISK_PATH"
PARTITION_EFI="/dev/disk/by-partlabel/efi"
PARTITION_SWAP="/dev/disk/by-partlabel/swap"
PARTITION_LINUX="/dev/disk/by-partlabel/linux"