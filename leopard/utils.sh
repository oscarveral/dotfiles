#!/usr/bin/env bash

# Function to close all cryptsetup containers opened.

close_cryptsetup_containers() {
    # List all mapped cryptsetup devices and close them
    local mapper
    for mapper in $(lsblk -rno NAME,TYPE | awk '$2=="crypt" {print $1}'); do
        if [ -e "/dev/mapper/$mapper" ]; then
            echo "Closing cryptsetup container: $mapper"
            cryptsetup close "$mapper"
        fi
    done
}

# Function to unmount everything under /mnt.

umount_all_under_mnt() {
	local targets
	targets=$(findmnt -rn -o TARGET | grep '^/mnt' | sort -r)
	for t in $targets; do
		echo "Unmounting $t"
		umount "$t"
	done
}

# Function to disable swap.

disable_swap() {
    echo "Disabling all swap devices"
    swapoff -a
}

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
