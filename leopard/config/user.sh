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

USER_HOME="/home/oscar"
if [ ! -d "$USER_HOME" ]; then
    printf "Creating home directory for user oscar...\n"
    mkdir -p "$USER_HOME" || abort "create home directory for user oscar"
    chown oscar:oscar "$USER_HOME" || abort "set owner of home directory for user oscar"
    chmod 754 "$USER_HOME" || abort "set permissions of home directory for user oscar"
fi

# Copy this dotfiles repository to the user's home.

if [ -d "$USER_HOME/dotfiles" ]; then
    printf "Directory $USER_HOME/dotfiles already exists. Removing it first.\n"
    rm -rf "$USER_HOME/dotfiles" || abort "remove existing $USER_HOME/dotfiles"
fi
cp -r "$DOTFILES_LOCAL_PATH" "$USER_HOME/dotfiles" || abort "copy dotfiles to user oscar home"
chown -R oscar:oscar "$USER_HOME/dotfiles" || abort "change owner of dotfiles to user oscar"
chmod -R 744 "$USER_HOME/dotfiles" || abort "set perms of dotfiles to 744"

# Set up the user's home directory with stow.

su oscar -c "cd $USER_HOME/dotfiles/leopard/files/home && stow --no-folding -t $USER_HOME -R oscar" || abort "stow user oscar home files"
rm -rf "$USER_HOME"/.bash_history