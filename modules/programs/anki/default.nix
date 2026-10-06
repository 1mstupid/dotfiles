{ pkgs, ... }:
{
  home.packages = [
    (pkgs.anki.withAddons (import ./addons.nix { inherit pkgs; }))
  ];
}
