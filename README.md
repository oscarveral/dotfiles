# Infrastructure

This repository contains all my dotfiles and installation scripts for my linux machines. The goal is to get a
deploy ready script to be able to configure specific machines any time with my desired dotfiles and configurations.

## Overview

This infrastructure supports automated system installation and configuration using machine-specific profiles. Each machine profile contains installation scripts, configuration files, and dotfiles tailored for specific hardware or use cases.

## Quick Start

Run the bootstrap script to start the installation process:

```bash
curl -fsSL https://raw.githubusercontent.com/oscarveral/dotfiles/refs/heads/main/boot.sh
bash boot.sh install
```
Or with custom parameters:

```bash
# Use a specific branch
DOTFILES_REF=development bash boot.sh
# Use a different repository
DOTFILES_REPO=username/dotfiles bash boot.sh
```

### Installation Modes

- `install`: Complete system installation from scratch (default).
- `config`: Apply configuration to existing system after initial installation.

### Usage

From the main repository root, run:

```bash
# Complete installation
bash boot.sh install
# Configuration after installation.
bash boot.sh config
```

## Machine Profiles

Each machine profile is self-contained with its own documentation, configuration files, and installation scripts.

### Available Profiles

- **[Leopard](leopard/README.md)** - Complete Arch Linux installation with full disk encryption

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DOTFILES_LOCAL_PATH` | Local path for dotfiles | `$HOME/dotfiles` |
| `DOTFILES_REPO` | GitHub repository | `oscarveral/dotfiles` |
| `DOTFILES_REF` | Git branch/tag to use | `main` |

## Dependencies

The bootstrap script automatically installs required dependencies based on the selected machine profile.

---

*This infrastructure is designed for personal use but can be adapted for similar setups. Use at your own risk and always test in a virtual machine first.*