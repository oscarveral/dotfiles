#!/usr/bin/env bash

# Set the hostname.

printf "Setting hostname...\n\n"

hostnamectl hostname --static "$MACHINE"
hostnamectl hostname --pretty "$MACHINE"
hostnamectl set-icon-name "computer"
hostnamectl set-chassis "laptop"
hostnamectl set-deployment "production"
hostnamectl set-location "mobile"