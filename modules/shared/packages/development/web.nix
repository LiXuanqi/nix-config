{ pkgs, ... }:
with pkgs;
[
  nodejs
  pnpm
  bun
  # typescript-language-server
  # typescript
  # nodePackages.prettier
  copilot-language-server
]