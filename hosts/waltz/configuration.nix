{ config, lib, pkgs, ... }:
let
  samaritan-sddm = pkgs.callPackage ../../modules/packages/samaritan-sddm.nix {};
in
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  systemd.services.kmonad = {
    description = "KMonad keyboard remapping";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    wants = [ "systemd-udev-settle.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /home/waltz/.config/kmonad/config.kbd";
      Restart = "on-failure";
      RestartSec = 2;
      User = "root";
    };
  };

  services.resolved = {
    enable = true;
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  
  time.timeZone = "America/Recife";
  
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver = {
  # 	enable = true;
  # 	autoRepeatDelay = 200;
  # 	autoRepeatInterval = 35;
  # 	windowManager.bspwm.enable = true;
  # };
  #


  services.displayManager.sddm = {
      enable = true;
      theme = "samaritan";
      wayland.enable = true;
      extraPackages = [
        samaritan-sddm
      ];
  };



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #
  # Audio
  #

  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line if you want to use JACK applications
    # jack.enable = true;
  };

  #
  # Bluetooth
  #

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.waltz = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfree = true;
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



  # List packages installed in system profile
  # You can use https://search.nixos.org/ to find more packages (and options).

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  system.stateVersion = "26.05";

}

