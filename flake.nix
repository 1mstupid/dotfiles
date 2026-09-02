{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";


    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url =
      "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    ...
  }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          {
            environment.systemPackages = [
             
            ];           
          }

          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak

          {
            _module.args = {
              inherit inputs;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.waltz = import ./home.nix;
          }
        ];

      };
    };
}





