{
  config,
  pkgs,
  fenix,
  ...
}:
{

  nixpkgs = {
    overlays = [ fenix.overlays.default ];
    config = {
      allowUnfree = true;
    };
  };
}
