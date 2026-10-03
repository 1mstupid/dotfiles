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
    programs.git
    programs.zsh-wrapper
    programs.gh
  ];

  home.activation.gitConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.local/state/git"

      printf '%s\n' \
        '[user]' \
        '    name = "Ítalo Barros"' \
        '    email = "italoHSB@tutamail.com"' \
        '[init]' \
        '    defaultBranch = main' \
        '[core]' \
        '    editor = hx' \
        '[credential "https://github.com"]' \
        '    helper =' \
        '    helper = !gh auth git-credential' \
        '[credential "https://gist.github.com"]' \
        '    helper =' \
        '    helper = !gh auth git-credential' \
        > "$HOME/.local/state/git/config"
    '';

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
