{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ../../modules/system/default.nix
      ./packages.nix
      ./hardware-configuration.nix
    ];

  users.users.waltz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  system.stateVersion = "26.05";
}

