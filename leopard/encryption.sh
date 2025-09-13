#!/usr/bin/env bash

# Function to prompt for a passphrase securely.

prompt_passphrase() {
    local context="$1"
	local p1 p2
	while true; do
		p1=$(gum input --password --prompt "Enter LUKS passphrase for ${context:-use}: ") || p1=""
		if [ -z "$p1" ]; then
			gum style --foreground 196 "Passphrase cannot be empty."
			continue
		fi
		p2=$(gum input --password --prompt "Confirm LUKS passphrase for ${context:-use}: ") || p2=""
		if [ "$p1" != "$p2" ]; then
			gum style --foreground 196 "Passphrases do not match. Try again."
			continue
		fi
		PASSPHRASE="$p1"
		# Clear locals
		unset p1 p2
		return 0
	done
}

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