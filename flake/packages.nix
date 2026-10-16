{ inputs, ... }:

{
  perSystem =
    { pkgs, system, ... }:
    let
      homeDirectory = "/home/waltz";

      sessionVariables = {
        NH_FLAKE = "${homeDirectory}/dotfiles";
        EDITOR = "hx";
        VISUAL = "hx";
        BROWSER = "helium";
        QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
      };
    in
    {
      packages = {
        tmux = import ../modules/home/programs/tmux.nix { inherit pkgs; };
        ncmpcpp = import ../modules/home/programs/ncmpcpp.nix { inherit pkgs; };
        anki = import ../modules/home/programs/anki { inherit pkgs; };
        helix = import ../modules/home/programs/helix.nix { inherit pkgs; };
        mango = import ../modules/home/programs/mango.nix { inherit pkgs inputs; };

        zsh = import ../modules/home/programs/zsh.nix {
          inherit pkgs inputs homeDirectory sessionVariables;
        };

        qs = inputs.quickshell.packages.${system}.qs;
        mpv = inputs.mpv.packages.${system}.default;
      };
    };
}
