{ config, lib, pkgs, programs, ... }:

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

    shell = "${programs.zsh-wrapper}/bin/zsh";

    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = "waltz";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
