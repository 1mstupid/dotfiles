{ config, inputs, ... }:
{
  perSystem = { pkgs, system, ... }:
    let
      sessionVariables = config.flake.session;
    in
    {
      packages = {
        # tmux = import ./home/programs/tmux.nix { inherit pkgs; };
        ncmpcpp = import ./home/programs/ncmpcpp.nix { inherit pkgs; };
        anki = import ./home/programs/anki { inherit pkgs; };
        helix = import ./home/programs/helix.nix { inherit pkgs; };
        mango = import ./home/programs/mango.nix { inherit pkgs inputs; };

        zsh = import ./home/programs/zsh.nix {
          inherit pkgs inputs sessionVariables;
          homeDirectory = config.flake.session.NH_FLAKE; # or set homeDirectory directly
        };

        qs = inputs.quickshell.packages.${system}.qs;
        mpv = inputs.mpv.packages.${system}.default;
      };
    };
}
