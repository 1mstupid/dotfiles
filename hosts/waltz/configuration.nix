{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ../../modules/default.nix
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

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  system.stateVersion = "26.05";
}

