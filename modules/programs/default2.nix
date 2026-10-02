{ pkgs, homeDirectory }:

{
  tmux = import ./tmux.nix {
    inherit pkgs;
  };

  git = import ./git.nix {
    inherit pkgs homeDirectory;
  };

  gh = import ./gh.nix {
    inherit pkgs homeDirectory;
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
