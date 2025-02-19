{
  inputs,
  config,
  pkgs,
  fenix,
  emacs-overlay,
  ...
}:
{

  nixpkgs = {
    overlays = [ inputs.fenix.overlays.default 
      inputs.emacs-overlay.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
}
