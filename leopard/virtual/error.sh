#!/usr/bin/env bash

abort() {
  printf "\e[31mInstall requires: %s\e[0m\n" "$1"
  printf "\n"
}