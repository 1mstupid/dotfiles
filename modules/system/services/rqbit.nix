{ config, lib, pkgs, ... }:

let
  cfg = config.service.rqbit;
in
{
  options.service.rqbit = {
    enable = lib.mkEnableOption "rqbit BitTorrent client";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rqbit;
      defaultText = lib.literalExpression "pkgs.rqbit";
      description = "The rqbit package to use.";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/rqbit";
      description = "Directory used by rqbit for downloads and state.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3030;
      description = "HTTP API/web UI port.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "rqbit";
      description = "User to run rqbit as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "rqbit";
      description = "Group to run rqbit as.";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open rqbit's HTTP port in the firewall.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
    };

    users.groups.${cfg.group} = {};

    networking.firewall.allowedTCPPorts =
      lib.mkIf cfg.openFirewall [ cfg.port ];

    systemd.service.rqbit = {
      description = "rqbit BitTorrent client";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;

        StateDirectory = "rqbit";
        WorkingDirectory = cfg.dataDir;

        ExecStart = lib.escapeShellArgs [
          "${cfg.package}/bin/rqbit"
          "server"
          "--http-api-listen-addr"
          "0.0.0.0:${toString cfg.port}"
          cfg.dataDir
        ];

        Restart = "on-failure";

        # Basic hardening
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ cfg.dataDir ];
      };
    };
  };
}
