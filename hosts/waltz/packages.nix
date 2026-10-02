{ config, pkgs, ... }:
let
  samaritan-sddm = pkgs.callPackage ../../modules/system/extra/samaritan-sddm.nix { };
in
{
environment.systemPackages = with pkgs; [
    vim 
    git
    samaritan-sddm
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.meslo-lg
    nerd-fonts.caskaydia-mono
  ];
  

  programs.zsh.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
  programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 2 --keep-since 2d";
      };
    };
  };

  services.displayManager.sddm = {
      enable = true;
      theme = "samaritan";
      wayland.enable = true;
      extraPackages = [
        samaritan-sddm
      ];
  };
}
