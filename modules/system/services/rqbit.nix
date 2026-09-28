{ config, lib, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/rqbit 0755 rqbit rqbit -"
  ];
  services.rqbit = {
    enable = true;
    downloadDir = "/home/waltz/Downloads";
  };
}

