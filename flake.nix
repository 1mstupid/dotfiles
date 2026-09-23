{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    ayugram-desktop = {
        url = "github:ndfined-crp/ayugram-desktop";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/waltz/configuration.nix
          {
            environment.systemPackages = [
             
            ];           
          }

          home-manager.nixosModules.home-manager

          {
            _module.args = {
              inherit inputs;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.waltz = import ./home/home.nix;
          }
        ];

      };
    };
}





