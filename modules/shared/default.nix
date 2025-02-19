{
  inputs,
  config,
  pkgs,
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
