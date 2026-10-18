{ inputs, config, ... }:

let
  system = "x86_64-linux";

  overlay-unstable = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ overlay-unstable ];
  };
in
{
  flake.nixosConfigurations.nixos-btw =
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ../hosts/waltz/configuration.nix

        inputs.umbriel.nixosModules.default
        inputs.home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.waltz = {
            imports = [
              config.flake.homeModules.default
              config.flake.homeModules.scripts
              config.flake.homeModules.alacritty
              config.flake.homeModules.ghostty
              config.flake.homeModules.zsh
              config.flake.homeModules.hx
              config.flake.homeModules.tmux
            ];
          };
        }
      ];
    };
}
