{ pkgs }:

pkgs.anki.withAddons (
  import ./addons.nix { inherit pkgs; }
)
