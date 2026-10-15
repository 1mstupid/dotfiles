{ config, self, ... }:
{
  flake.homeModules.default = { config, pkgs, lib, ... }:
    let
      home = config.home.homeDirectory;
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
    imports = [
      ./packages.nix
    ];

    home = {
      username = "waltz";
      homeDirectory = "/home/waltz";
      stateVersion = "26.05";
      inherit sessionVariables;
    };

    xdg = {
      enable = true;
      configHome = "${config.home.homeDirectory}/.local/xdg/config";
      dataHome = "${config.home.homeDirectory}/.local/xdg/data";
      stateHome = "${config.home.homeDirectory}/.local/xdg/state";
      cacheHome = "${config.home.homeDirectory}/.cache/xdg";

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
        desktop = config.home.homeDirectory;
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        publicShare = "${config.home.homeDirectory}/Public";
      };
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;

      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionPath = [
      "${config.home.homeDirectory}/.cargo/bin"
      "${config.home.homeDirectory}/.local/bin"
    ];

    programs.home-manager.enable = true;

    programs.bash.enable = true;

    home.file = {
      ".local/share/wallpapers".source =
        config.lib.file.mkOutOfStoreSymlink
          "/home/waltz/dotfiles/assets/wallpaper";

      ".local/bin".source =
        config.lib.file.mkOutOfStoreSymlink
          "/home/waltz/dotfiles/assets/bin";
    };

    home.packages = [
      programs.zsh-wrapper
    ];

    services.mpd = {
      enable = true;
      musicDirectory = "/home/waltz/Music";

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }
      '';
    };

    services.mpdris2.enable = true;

    systemd.user.services.mpdris2.Service.Environment = [
      "XDG_CONFIG_HOME=%t/mpdris2"
    ];

    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        core.editor = "hx";
        credential."https://github.com".helper = [ "" "!gh auth git-credential" ];
        credential."https://gist.github.com".helper = [ "" "!gh auth git-credential" ];
        user = {
          name = "Ítalo Barros";
          email = "italoHSB@tutamail.com";
        };
      };
    };

    programs.gh.enable = true;

    dconf = {
      enable = false;

      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
        };
      };
    };
  };
}
