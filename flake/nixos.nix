{ inputs, ... }:

{
  flake.nixosConfigurations.nixos-btw =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ../hosts/waltz/configuration.nix

        inputs.home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.waltz = {
            imports = [
              ../modules/home/home.nix
            ];
          };
        }
      ];
    };
}
