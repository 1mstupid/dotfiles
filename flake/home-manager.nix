{
  flake.homeModules = {
    default = ../modules/home/home.nix;
    ghostty = ../modules/home/programs/ghostty.nix;
  };
}
