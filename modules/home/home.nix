{
  config,
  pkgs,
  lib,
  inputs,
  programs,
  sessionVariables,
  ...
}:

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
    ".local/xdg/config/mimeapps.list".source =
      programs.xdg.mimeapps;

    ".local/xdg/config/user-dirs.dirs".source =
      programs.xdg.userDirs;

    ".local/xdg/config/user-dirs.locale".source =
      programs.xdg.userDirsLocale;

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
    user ={
      name = "Ítalo Barros";
      email = "italoHSB@tutamail.com";
    };
    settings = {
      init.defaultBranch = "main";
      core.editor = "hx";
      credential."https://github.com".helper = [ "" "!gh auth git-credential" ];
      credential."https://gist.github.com".helper = [ "" "!gh auth git-credential" ];
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
}
