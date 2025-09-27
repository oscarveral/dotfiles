#!/usr/bin/env bash

# Create the single user if it doesn't already exist.

printf "\nCreating user oscar...\n"

if id -u oscar &>/dev/null; then
    printf "User oscar already exists\n"
else
    useradd -c "Óscar Vera López" -s /bin/bash oscar || abort "create user oscar"
fi

# Set the user password.

prompt_passphrase "oscar user"
printf "%s\n" "oscar:$PASSPHRASE" | chpasswd || abort "set user oscar password"
unset PASSPHRASE

# Create user directories.

mkdir -p /home/oscar

# Copy this dotfiles repository to the user's home.

if [ -d /home/oscar/dotfiles ]; then
    printf "Directory /home/oscar/dotfiles already exists. Removing it first.\n"
    rm -rf /home/oscar/dotfiles || abort "remove existing /home/oscar/dotfiles"
fi
cp -r "$DOTFILES_LOCAL_PATH" /home/oscar/dotfiles || abort "copy dotfiles to user oscar home"
chown -R oscar:oscar /home/oscar/dotfiles || abort "change owner of dotfiles to user oscar"
chmod -R 744 /home/oscar/dotfiles || abort "set perms of dotfiles to 744"

# Set up the user's home directory with stow.

stow -d /home/oscar/dotfiles/leopard/files/home -t /home/oscar -R oscar || abort "stow user oscar home files"