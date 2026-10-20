{self, ...}: {
  flake.nixosModules.core = {pkgs, ...}: let
    modules = with self.nixosModules; [
      user
      bootloader
      settings
      hardware
      locale
    ];
  in {
    imports =
      [
        /etc/nixos/hardware-configuration.nix
      ]
      ++ modules;
    environment.systemPackages = with pkgs; [
      vim
      unzip
      p7zip-rar
      pamixer
      usbutils
      zoxide
      ffmpeg
      lsof
      gvfs
      bluez
      libnotify
      python315
      curlWithGnuTls
      wget
      ripgrep
    ];
    system.stateVersion = "26.05";
  };
}
