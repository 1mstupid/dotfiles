{ pkgs, homeDirectory }:

{
  tmux = import ./tmux.nix {
    inherit pkgs;
  };

  git = import ./git.nix {
    inherit pkgs;
  };

  gh = import ./gh.nix {
    inherit pkgs;
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
