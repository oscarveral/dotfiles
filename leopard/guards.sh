#!/usr/bin/env bash

# Must be an Arch distro.
[[ -f /etc/arch-release ]] || abort "Vanilla Arch"

# Must not be an Arch derivative distro.
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  [[ -f "$marker" ]] && abort "Vanilla Arch"
done

# Must be x86 only to fully work.
[ "$(uname -m)" != "x86_64" ] && abort "x86_64 CPU"

# Cleared all guards.
printf "%s\n\n" "Guards: OK"