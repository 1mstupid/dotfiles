{ config, lib, pkgs, inputs, ... }:
let
  zshWrapper = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.zsh-wrapper;
in
{
  imports = [
    ../../modules/system/default.nix
    ./packages.nix
    ./hardware-configuration.nix
  ];

  users.users.waltz = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
    ];

    shell = zshWrapper;

    packages = with pkgs; [
      tree
    ];
  };
  environment.shells = [ zshWrapper ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
