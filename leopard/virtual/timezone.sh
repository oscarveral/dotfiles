#!/usr/bin/env bash

# Set timezone.

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime || abort "set timezone"

# Sync hardware clock.

hwclock --systohc || abort "sync hardware clock"

# Show time.

printf "\nLinked /etc/localtime to Europe/Madrid\n"
timedatectl
printf "\n"