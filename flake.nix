{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";

  inputs = {
   flake-parts.url = "github:hercules-ci/flake-parts";

   "nix-cachyos-kernel" = {
        flake = true;
        type = "github";
        owner = "xddxdd";
        repo = "nix-cachyos-kernel";
        ref = "release";
    };

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    quickshell.url = "github:1mstupid/quickshell-config";

    mpv.url = "github:1mstupid/mpv";
    
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
    flake-parts,
    ...
  }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    packages.${system} = {
        tmux = import ./modules/programs/tmux.nix {
          inherit pkgs;
        };
        helix = import ./modules/programs/helix.nix {
          inherit pkgs;
        };
      };


    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/waltz/configuration.nix

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





