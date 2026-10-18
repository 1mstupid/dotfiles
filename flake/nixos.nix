
{ inputs, config, ... }:
let
  system = "x86_64-linux";

  overlay-unstable = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
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
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [ overlay-unstable ];
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit inputs;
            };

            users.waltz.imports = [
              config.flake.homeModules.default
            ];
          };
        }
      ];
    };
}
