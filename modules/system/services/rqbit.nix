{ config, lib, pkgs, ... }:

{
  services.rqbit = {
    enable = true;
    settings = {
      output_dir = "/home/waltz/Downloads";
    };
  };
}

