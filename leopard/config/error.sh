#!/usr/bin/env bash

abort() {
  printf "\e[31mInstall requires: %s\e[0m\n" "$1"
  printf "\n"
}

prompt_passphrase() {
    local context="$1"
	local p1 p2
	while true; do
		p1=$(gum input --password --prompt "Enter passphrase for ${context:-use}: ") || p1=""
		if [ -z "$p1" ]; then
			gum style --foreground 196 "Passphrase cannot be empty."
			continue
		fi
		p2=$(gum input --password --prompt "Confirm passphrase for ${context:-use}: ") || p2=""
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
