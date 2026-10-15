{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    let
      homeDirectory = "/home/waltz";

      sessionVariables = {
        NH_FLAKE = "${homeDirectory}/dotfiles";
        XDG_CONFIG_HOME = "${homeDirectory}/.local/xdg/config";
        GIT_CONFIG_GLOBAL = "${homeDirectory}/.local/state/git/config";
        EDITOR = "hx";
        QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
        VISUAL = "hx";
        BROWSER = "helium";
      };

      programs = import ../modules/home/programs {
        inherit config pkgs inputs homeDirectory sessionVariables;
      };
    in
    {
      packages = programs;
    };
}
