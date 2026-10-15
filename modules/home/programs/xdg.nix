{ config, ... }:
let
  home = config.home.homeDirectory;
in
{
  xdg = {
    enable = true;

    configHome = "${home}/.local/xdg/config";
    dataHome   = "${home}/.local/xdg/data";
    stateHome  = "${home}/.local/xdg/state";
    cacheHome  = "${home}/.cache/xdg";

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";

        "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
        "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";

        "text/plain" = "Helix.desktop";
        "text/markdown" = "Helix.desktop";
        "text/x-c" = "Helix.desktop";
        "text/x-c++" = "Helix.desktop";
        "text/x-python" = "Helix.desktop";
        "text/x-rust" = "Helix.desktop";
        "text/x-shellscript" = "Helix.desktop";

        "application/pdf" = "sioyek.desktop";

        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/svg+xml" = "librewolf.desktop";

        "video/mp4" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";

        "audio/mpeg" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = home;
      download = "${home}/Downloads";
      documents = "${home}/Documents";
      music = "${home}/Music";
      pictures = "${home}/Pictures";
      videos = "${home}/Videos";
      publicShare = "${home}/Public";
    };
  };
}
