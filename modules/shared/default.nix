{
  config,
  pkgs,
  fenix,
  emacs-overlay,
  ...
}:
{

  nixpkgs = {
    overlays = [ fenix.overlays.default 
      emacs-overlay.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
}
