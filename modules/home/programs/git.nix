{ pkgs, homeDirectory }:

pkgs.symlinkJoin {
  name = "git";

  paths = [ pkgs.git ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/git \
      --set GIT_CONFIG_GLOBAL "${homeDirectory}/.local/state/git/config"
  '';
}
