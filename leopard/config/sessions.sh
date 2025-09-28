#!/usr/bin/env bash

# Enable ly display manager.

systemctl enable ly.service || abort "enable ly service"

# Configure ly.

cp "$MACHINE_PATH/files/etc/ly/config.ini" /etc/ly/config.ini || abort "copy ly config"

# Copy wayland session file.
rm -rf /usr/share/wayland-sessions/*
cp "$MACHINE_PATH/files/usr/share/wayland-sessions/hyprland.desktop" /usr/share/wayland-sessions/hyprland.desktop || abort "copy hyprland session"
cp "$MACHINE_PATH/files/usr/share/wayland-sessions/hyprland-uwsm.desktop" /usr/share/wayland-sessions/hyprland-uwsm.desktop || abort "copy hyprland-uwsm session"