{ pkgs, inputs, homeDirectory }:
{
  tmux = import ./tmux.nix {
    inherit pkgs;
  };
  zsh = import ./zsh.nix {
    inherit pkgs;
  };


  gh = import ./gh.nix {
    inherit pkgs homeDirectory;
  };

  git = import ./git.nix {
    inherit pkgs;
    homeDirectory = "/home/waltz";
  };

  alacritty = import ./alacritty.nix {
    inherit pkgs homeDirectory;
  };

  helix = import ./helix.nix {
    inherit pkgs;
  };

  mango = import ./mango.nix {
    inherit pkgs inputs;
  };

  qs = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.qs;

  xdg = import ./xdg.nix {
    inherit pkgs homeDirectory;
  };
}
