{ pkgs }:

let
  gitConfig = pkgs.writeText "gitconfig" ''
    [user]
      name = "Ítalo Barros"
      email = "italoHSB@tutamail.com"

    [init]
      defaultBranch = main

    [core]
      editor = helix
  '';
in
pkgs.symlinkJoin {
  name = "git";

  paths = [ pkgs.git ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/git \
      --set GIT_CONFIG_GLOBAL ${gitConfig}
  '';
}
