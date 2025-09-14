#!/usr/bin/env bash

# Copy the repository to a temporary location.

DOTFILES_CHROOT_PATH="/root/dotfiles"

printf "\nCopying dotfiles to chroot environment...\n\n"
printf "Source: %s\n" "$DOTFILES_LOCAL_PATH"
printf "Destination: %s\n" "/mnt$DOTFILES_CHROOT_PATH"

rm -rf "/mnt$DOTFILES_CHROOT_PATH"
cp -r "$DOTFILES_LOCAL_PATH" "/mnt$DOTFILES_CHROOT_PATH" || abort "copy dotfiles"

# Add execution permission to all scripts in the chroot environment.

chmod -R +x "/mnt$DOTFILES_CHROOT_PATH"

# Change to chroot environment.

arch-chroot /mnt $DOTFILES_CHROOT_PATH/$MACHINE/virtual/common.sh || abort "enter chroot environment"