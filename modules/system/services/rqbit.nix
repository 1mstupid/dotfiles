{ config, lib, pkgs, ... }:

{
  services.rqbit = {
    enable = true;
    downloadDir = "/var/lib/rqbit/downloads";
    user = "rqbit";
    group = "rqbit";
  };
}

