{ config, lib, pkgs, ... }:

{
  options.services.rqbit = {
    enable = lib.mkEnableOption "rqbit";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rqbit;
    };
  };

  config = lib.mkIf config.services.rqbit.enable {
    systemd.services.rqbit = {
      description = "rqbit BitTorrent client";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        ExecStart = "${config.services.rqbit.package}/bin/rqbit server";
        Restart = "on-failure";
      };
    };
  };
}

