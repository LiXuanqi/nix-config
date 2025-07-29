# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Nix configuration repository** managing system configurations for both **macOS (nix-darwin)** and **NixOS** using Nix flakes. It provides a unified, reproducible development environment across different operating systems.

## Common Development Commands

### System Rebuilds
```bash
# macOS (nix-darwin)
darwin-rebuild switch --flake .

# NixOS
sudo nixos-rebuild switch --flake .#nixos
```

### Flake Management
```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake update nixpkgs

# Check flake configuration
nix flake check

# Show flake info
nix flake show
```

### Development and Testing
```bash
# Build configuration without applying
nix build .#darwinConfigurations.1x7s-Laptop.system  # macOS
nix build .#nixosConfigurations.nixos.config.system.build.toplevel  # NixOS

# Enter development shell with flake dependencies
nix develop

# Garbage collection
nix-collect-garbage -d
sudo nix-collect-garbage -d  # system-wide on NixOS
```

## Architecture Overview

### Core Structure
- **`flake.nix`** - Main configuration defining inputs, outputs, and host configurations
- **`flake.lock`** - Dependency lock file ensuring reproducibility
- **`hosts/`** - Host-specific configurations
  - `darwin/` - macOS system configuration
  - `nixos/` - NixOS system configuration with Hyprland + GNOME
- **`modules/`** - Modular configuration components
  - `shared/` - Cross-platform modules
  - `darwin/` - macOS-specific modules  
  - `nixos/` - NixOS-specific modules
- **`dotfiles/.config/`** - Application configuration files

### Key Technologies
- **Desktop**: Hyprland (NixOS), native macOS
- **Editor**: Neovim + Custom Emacs with Doom configuration
- **Terminal**: WezTerm with Zsh + Starship
- **Development**: Rust (Fenix toolchain), Node.js, TypeScript, LSP servers

### Configuration Philosophy
- **Modular design** with shared/platform-specific separation
- **Home Manager** integration for user-level configurations
- **Reproducible builds** via flake pinning
- **Cross-platform consistency** where possible

## Important Notes

### Flake Inputs
The configuration uses several key inputs:
- `nixpkgs` - Main package repository
- `home-manager` - User environment management
- `nix-darwin` - macOS system configuration
- `hyprland` - Wayland compositor for NixOS
- `fenix` - Rust toolchain management
- Custom overlays for Emacs and other specialized packages

### Host Configurations
- **`1x7s-Laptop`** - macOS Darwin system
- **`nixos`** - NixOS system with Hyprland/GNOME

### Dotfiles Management
Application configurations in `dotfiles/.config/` are managed through Home Manager and linked to appropriate system locations. Major configurations include:
- `wezterm/` - Terminal emulator
- `hypr/` - Hyprland window manager (NixOS)
- `doom/` + `emacs/` - Editor configurations
- `waybar/` - Status bar (NixOS)

When modifying configurations, always test with the appropriate rebuild command before committing changes.