{ pkgs, inputs, homeDirectory, sessionVariables }:

let
  zsh-wrapper = import ./zsh.nix {
    inherit pkgs inputs homeDirectory sessionVariables;
  };
in
{
  tmux = import ./tmux.nix {
    inherit pkgs;
  };

  ncmpcpp = import ./ncmpcpp.nix {
    inherit pkgs;
  };

  anki = import ./anki {
    inherit pkgs;
  };

  inherit zsh-wrapper;

  gh = import ./gh.nix {
    inherit pkgs homeDirectory;
  };

  git = import ./git.nix {
    inherit pkgs homeDirectory;
  };

  helix = import ./helix.nix {
    inherit pkgs;
  };

  mango = import ./mango.nix {
    inherit pkgs inputs;
  };

  qs = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.qs;
  mpv = inputs.mpv.packages.${pkgs.stdenv.hostPlatform.system}.default;


  xdg = import ./xdg.nix {
    inherit pkgs homeDirectory;
  };
}
