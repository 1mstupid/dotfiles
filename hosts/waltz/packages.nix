{ config, pkgs, ... }:
let
  samaritan-sddm = pkgs.callPackage ../../modules/packages/samaritan-sddm.nix { };
in
{
environment.systemPackages = with pkgs; [
    vim 
    git
    kitty
    waybar
    samaritan-sddm
    # hyprpaper
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts        # broad Unicode/CJK/etc coverage
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.meslo-lg
    nerd-fonts.caskaydia-mono
  ];
  

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
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
