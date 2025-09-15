#!/usr/bin/env bash

# Set the root password.

prompt_passphrase "root user"
printf "%s\n" "root:$PASSPHRASE" | chpasswd || abort "set root password"
unset PASSPHRASE