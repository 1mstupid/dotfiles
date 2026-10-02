{ pkgs }:

pkgs.symlinkJoin {
  name = "gh";

  paths = [ pkgs.gh ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/gh \
      --set GH_CONFIG_DIR "$HOME/.local/state/gh"
  '';
}
