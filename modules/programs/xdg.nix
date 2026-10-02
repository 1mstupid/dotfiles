{ pkgs, homeDirectory }:

let
  lib = pkgs.lib;

  xdgConfig = "${homeDirectory}/.local/xdg/config";
  xdgData   = "${homeDirectory}/.local/xdg/data";
  xdgState  = "${homeDirectory}/.local/xdg/state";
  xdgCache  = "${homeDirectory}/.cache/xdg";

  wrapXdg = pkg:
    pkgs.symlinkJoin {
      name = "${pkg.pname or pkg.name}-xdg";
      paths = [ pkg ];

      nativeBuildInputs = [ pkgs.makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/${lib.getExeName (lib.getExe pkg)} \
          --set XDG_CONFIG_HOME ${xdgConfig} \
          --set XDG_DATA_HOME   ${xdgData} \
          --set XDG_STATE_HOME  ${xdgState} \
          --set XDG_CACHE_HOME  ${xdgCache}
      '';
    };

  mimeapps = pkgs.writeText "mimeapps.list" ''
    [Default Applications]

    # Web
    text/html=helium.desktop
    x-scheme-handler/http=helium.desktop
    x-scheme-handler/https=helium.desktop

    # Torrents
    application/x-bittorrent=org.qbittorrent.qBittorrent.desktop
    x-scheme-handler/magnet=org.qbittorrent.qBittorrent.desktop

    # Text / code
    text/plain=Helix.desktop
    text/markdown=Helix.desktop
    text/x-c=Helix.desktop
    text/x-c++=Helix.desktop
    text/x-python=Helix.desktop
    text/x-rust=Helix.desktop
    text/x-shellscript=Helix.desktop

    # Documents
    application/pdf=sioyek.desktop

    # Images
    image/jpeg=imv.desktop
    image/png=imv.desktop
    image/gif=imv.desktop
    image/webp=imv.desktop
    image/svg+xml=librewolf.desktop

    # Video
    video/mp4=mpv.desktop
    video/webm=mpv.desktop
    video/x-matroska=mpv.desktop
    video/quicktime=mpv.desktop

    # Audio
    audio/mpeg=mpv.desktop
    audio/ogg=mpv.desktop
    audio/flac=mpv.desktop
    audio/wav=mpv.desktop
  '';

  userDirs = pkgs.writeText "user-dirs.dirs" ''
    XDG_DESKTOP_DIR="${homeDirectory}"
    XDG_DOWNLOAD_DIR="${homeDirectory}/downloads"
    XDG_DOCUMENTS_DIR="${homeDirectory}/documents"
    XDG_MUSIC_DIR="${homeDirectory}/music"
    XDG_PICTURES_DIR="${homeDirectory}/pictures"
    XDG_VIDEOS_DIR="${homeDirectory}/videos"
    XDG_PUBLICSHARE_DIR="${homeDirectory}/public"
    XDG_TEMPLATES_DIR="${homeDirectory}/templates"
  '';

  userDirsLocale = pkgs.writeText "user-dirs.locale" ''
    C
  '';
in
{
  mpv = wrapXdg pkgs.mpv;
  imv = wrapXdg pkgs.imv;
  sioyek = wrapXdg pkgs.sioyek;
  helix = wrapXdg pkgs.helix;

  inherit mimeapps userDirs userDirsLocale;
}
