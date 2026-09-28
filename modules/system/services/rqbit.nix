{ config, lib, pkgs, ... }:

{
  services.rqbit = {
    enable = true;
    user = "waltz";
    group = "users";
    downloadDir = "/home/waltz/Downloads";
  };
  systemd.tmpfiles.rules = [
    "a+ /home/waltz - - - - u:rqbit:x"
    "a+ /home/waltz/Downloads - - - - u:rqbit:rwx"
  ];
}

