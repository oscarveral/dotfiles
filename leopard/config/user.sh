#!/usr/bin/env bash

# Create the single user if it doesn't already exist.

if id -u oscar &>/dev/null; then
    echo "User oscar already exists"
else
    useradd -m -c "Óscar Vera López" -s /bin/bash oscar || abort "create user oscar"
fi

# Set the user password.
prompt_passphrase "oscar user"
printf "%s\n" "oscar:$PASSPHRASE" | chpasswd || abort "set user oscar password"
unset PASSPHRASE