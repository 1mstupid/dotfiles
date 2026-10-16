{ config, lib, pkgs, inputs, ... }:
let
  zsh-wrapper = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.zsh;
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

    shell = zsh-wrapper;

    packages = with pkgs; [
      tree
    ];
  };
  environment.systemPackages = [
    zsh-wrapper
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
