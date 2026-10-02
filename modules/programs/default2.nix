{ pkgs, homeDirectory }:
{
  tmux = import ./tmux.nix {
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
    inherit pkgs;
  };
}
