#!/usr/bin/env bash

ansi_art='
       ░██               ░██        ░████ ░██░██                       
       ░██               ░██       ░██       ░██                       
 ░████████  ░███████  ░████████ ░████████ ░██░██  ░███████   ░███████  
░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░██    ░██ ░██        
░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░█████████  ░███████  
░██   ░███ ░██    ░██    ░██       ░██    ░██░██ ░██               ░██ 
 ░█████░██  ░███████      ░████    ░██    ░██░██  ░███████   ░███████ '

clear
printf "\n%s\n\n" "$ansi_art"
timedatectl
printf "\n"

# Install dependencies.

sudo pacman -S --noconfirm --needed git gum mokutil

# Clone and setup dotfiles repository.

DOTFILES_LOCAL_PATH="${DOTFILES_LOCAL_PATH:-$HOME/.local/share/dotfiles}"
DOTFILES_REPO="${DOTFILES_REPO:-oscarveral/dotfiles}"
printf "\nCloning my dotfiles from: https://github.com/%s.git\n" "$DOTFILES_REPO"
rm -rf "$DOTFILES_LOCAL_PATH"
git clone "https://github.com/${DOTFILES_REPO}.git" "$DOTFILES_LOCAL_PATH" >/dev/null
DOTFILES_REF="${DOTFILES_REF:-main}"
if [[ $DOTFILES_REF != "main" ]]; then
  printf "\eUsing branch: %s\n" "$DOTFILES_REF"
  cd "$DOTFILES_LOCAL_PATH" || exit 1
  git fetch origin "${DOTFILES_REF}" && git checkout "${DOTFILES_REF}"
  cd - || exit 1
fi

# Select machine to install.

printf "\n"
MACHINE_LIST=$(find "$DOTFILES_LOCAL_PATH" -maxdepth 1 -type d ! -path "$DOTFILES_LOCAL_PATH" | xargs -n1 basename | grep -v '^\.git$')
MACHINE=$(printf "%s\n" $MACHINE_LIST | gum choose)
if [ -z "$MACHINE" ]; then
  printf "Error: No machine selected. Exiting.\n"
  exit 1
fi
printf "Selected installation machine: %s\n" "$MACHINE"
MACHINE_PATH="$DOTFILES_LOCAL_PATH/$MACHINE"
if [ ! -f "$MACHINE_PATH/install.sh" ]; then
  printf "Error: No installation script found for machine: %s. Exiting.\n" "$MACHINE"
  exit 1
fi

# Load error handling script.
source "$DOTFILES_LOCAL_PATH/error.sh"

# Run installation script for selected machine.

source "$MACHINE_PATH/install.sh"
