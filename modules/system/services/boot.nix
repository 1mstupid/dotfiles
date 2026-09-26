{ inputs, config, ... }:{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = inputs."nix-cachyos-kernel".legacyPackages.x86_64-linux.linuxPackages-cachyos-latest-lto-x86_64-v3;
  };
}
