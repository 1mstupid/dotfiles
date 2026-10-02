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
    programs = import ./modules/programs/default2.nix {
      inherit pkgs;
      homeDirectory = "/home/waltz";
    };
  in
  {
    packages.${system} = programs;
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./hosts/waltz/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit inputs;
            tmux = self.packages.${system}.tmux;
            helix = self.packages.${system}.helix;
            alacritty = self.packages.${system}.alacritty;
            mango = self.packages.${system}.mango;
            git = self.packages.${system}.git;
            gh = self.packages.${system}.gh;
          };

          home-manager.users.waltz = {
            imports = [
              ./modules/home/home.nix
            ];
          };
        }
      ];
    };
  };
}





