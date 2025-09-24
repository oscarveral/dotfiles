#!/usr/bin/env bash

# Make encrypted volume for swap.

prompt_passphrase "swap volume"

printf "%s" "$PASSPHRASE" | \
	cryptsetup luksFormat --batch-mode --label crypt-swap --key-file=- "$PARTITION_SWAP" || abort "luksFormat swap"
printf "%s" "$PASSPHRASE" | \
	cryptsetup open --key-file=- "$PARTITION_SWAP" swap || abort "open swap"
unset PASSPHRASE

# Make encrypted volume for root.

prompt_passphrase "root volume"

printf "%s" "$PASSPHRASE" | \
    cryptsetup luksFormat --batch-mode --label crypt-linux --key-file=- "$PARTITION_LINUX" || abort "luksFormat linux"
printf "%s" "$PASSPHRASE" | \
    cryptsetup open --key-file=- "$PARTITION_LINUX" linux || abort "open linux"
unset PASSPHRASE

# Export encrypted volume paths.

CONTAINER_SWAP="/dev/mapper/swap"
CONTAINER_LINUX="/dev/mapper/linux"

# Print status.
printf "\n"
lsblk -o NAME,LABEL,PARTLABEL "$DISK"
printf "\n"