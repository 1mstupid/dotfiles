{ config, lib, pkgs, ... }:

{
  services.rqbit = {
    enable = true;
    downloadDir = "/home/waltz/Downloads";
  };
}

