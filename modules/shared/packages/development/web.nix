{ pkgs, ... }:
with pkgs;
[
  nodejs
  pnpm
  # typescript-language-server
  # typescript
  # nodePackages.prettier
  copilot-language-server
]