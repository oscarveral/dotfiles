#!/usr/bin/env bash

# Enable ly display manager.

systemctl enable ly.service || abort "enable ly service"

# Configure ly.

cp "$MACHINE_PATH/files/etc/ly/config.ini" /etc/ly/config.ini || abort "copy ly config"