{ config, lib, ... }:
{
  networking.hostName = "nixos-btw";
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 8080 ];
    allowPing = false;
  };
  services.resolved = {
    enable = true;
  };

  networking.nameservers = [
    "1.1.1.1"
    "9.9.9.9"
  ];
}
