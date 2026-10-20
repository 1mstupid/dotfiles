
{...}: {
  flake.nixosModules.media = { config, lib, pkgs, ... }:
  let
    mediaGroup = "media";

    mediaRoot = "/srv/media";
    downloadsRoot = "/srv/downloads";

    komgaDomain = "komga.example.com";
    qbittorrentDomain = "torrent.example.com";
  in
  {
    users.groups.${mediaGroup} = {};

    users.users.komga.extraGroups = [ mediaGroup ];
    users.users.qbittorrent.extraGroups = [ mediaGroup ];

    systemd.tmpfiles.rules = [
      "d ${mediaRoot}                 2775 root ${mediaGroup} -"
      "d ${mediaRoot}/books           2775 root ${mediaGroup} -"
      "d ${mediaRoot}/comics          2775 root ${mediaGroup} -"
      "d ${mediaRoot}/manga           2775 root ${mediaGroup} -"

      "d ${downloadsRoot}             2775 root ${mediaGroup} -"
      "d ${downloadsRoot}/incomplete  2775 root ${mediaGroup} -"
      "d ${downloadsRoot}/complete    2775 root ${mediaGroup} -"
    ];

    services.komga = {
      enable = true;

      settings = {
        "server.port" = 25600;
        "server.address" = "127.0.0.1";
      };
    };

    services.qbittorrent = {
      enable = true;
      webuiPort = 8080;

      serverConfig = {
        Preferences = {
          WebUI = {
            LocalHostAuth = false;
          };

          Downloads = {
            SavePath = "${downloadsRoot}/complete/";
            TempPath = "${downloadsRoot}/incomplete/";
            TempPathEnabled = true;
          };
        };
      };
    };
    networking.firewall.allowedTCPPorts = [
      8080
      25600
    ];
  };
}
