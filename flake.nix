{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";

  inputs = {
   "nix-cachyos-kernel" = {
        flake = true;
        type = "github";
        owner = "xddxdd";
        repo = "nix-cachyos-kernel";
        ref = "release";
    };
    mango.url = "github:mangowm/mango";

    quickshell.url = "github:1mstupid/quickshell-config";
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
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

            home-manager.users.waltz = {
              imports = [
                inputs.mango.hmModules.mango
                ./modules/home/home.nix
              ];
            };
          }
        ];

      };
    };
}





