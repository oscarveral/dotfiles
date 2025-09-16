#!/usr/bin/env bash

# Copy the NTP configuration file.

printf "\nCopying NTP configuration file...\n\n"
cp "$MACHINE_PATH/files/etc/systemd/timesyncd.conf" /etc/systemd

# Enable the NTP service.

systemctl enable --now systemd-timesyncd || abort "enable NTP"