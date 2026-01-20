# Repository Guidelines

## Project Structure & Module Organization
This is a Nix flake repository that manages macOS (nix-darwin) and NixOS configurations.
- `flake.nix` / `flake.lock`: entry point and pinned inputs.
- `hosts/`: host-specific configs (`hosts/darwin`, `hosts/nixos`).
- `modules/`: reusable modules split by platform (`modules/shared`, `modules/darwin`, `modules/nixos`).
- `dotfiles/`: app config files wired via Home Manager (e.g., `dotfiles/.config/wezterm`, `dotfiles/.config/hypr`).

## Build, Test, and Development Commands
Use the commands below to validate changes:
- `darwin-rebuild switch --flake .` (macOS) rebuilds and applies the Darwin config.
- `sudo nixos-rebuild switch --flake .#nixos` (NixOS) rebuilds and applies the NixOS config.
- `nix build .#darwinConfigurations.1x7s-Laptop.system` or `nix build .#nixosConfigurations.nixos.config.system.build.toplevel` builds without applying.
- `nix flake check` validates the flake.
- `nix flake update` / `nix flake update nixpkgs` updates inputs.
- `nix develop` drops into a dev shell.

## Coding Style & Naming Conventions
- Nix files use 2-space indentation; keep attribute names descriptive and grouped by purpose.
- Prefer splitting large changes into `modules/shared` vs. platform-specific modules.
- Name new modules to match their function (e.g., `modules/shared/packages/tools.nix`).
- Keep `dotfiles/` paths aligned with app names.

## Testing Guidelines
There is no standalone test suite. Use `nix flake check` and a platform rebuild as the primary validation steps. For dotfile changes, open the affected app to confirm behavior.

## Commit & Pull Request Guidelines
Recent history mixes simple messages (`Update flake`) with Conventional Commit-style prefixes (`feat(homebrew): ...`). Prefer `type(scope): summary` when possible and keep summaries short. PRs should include:
- a brief description of the change and affected host(s),
- command(s) used for validation,
- screenshots only when UI changes are involved (e.g., Hyprland/Waybar).

## Configuration Notes
Homebrew is managed declaratively via `modules/darwin/homebrew.nix`. Avoid manual `brew install` unless explicitly needed and documented.
