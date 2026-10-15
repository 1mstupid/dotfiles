{ lib, ... }:
{
  options.flake.session = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  config.flake.session = {
    NH_FLAKE = "/home/waltz/dotfiles";
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "helium";
  };
}
