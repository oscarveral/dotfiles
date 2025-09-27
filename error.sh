#!/usr/bin/env bash

# Give people a chance to retry running the installation
catch_errors() {

  if command -v gum >/dev/null && gum confirm "Retry installation?"; then
    bash "$DOTFILES_LOCAL_PATH/boot.sh"
  else
  rm -rf "$DOTFILES_LOCAL_PATH"
  printf "%s\n" "You can retry later. Goodbye!"
  fi
}

trap catch_errors ERR
trap catch_errors INT QUIT

abort() {
  printf "\e[31mInstall failed: %s\e[0m\n" "$1"
  printf "\n"
}