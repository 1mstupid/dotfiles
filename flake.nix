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
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";

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

    homeDirectory = "/home/waltz";

    sessionVariables = {
      NH_FLAKE = "${homeDirectory}/dotfiles";
      XDG_CONFIG_HOME = "${homeDirectory}/.local/xdg/config";
      GIT_CONFIG_GLOBAL = "${homeDirectory}/.local/state/git/config";
      EDITOR = "hx";
      QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
      VISUAL = "hx";
      BROWSER = "helium";
    };

    programs = import ./modules/programs/default.nix {
      inherit pkgs inputs homeDirectory sessionVariables;
      zsh = self.packages.${system}.zsh-wrapper;
    };
  in
  {
    packages.${system} = programs;
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = {
        inherit inputs self;
      };

      modules = [
        ./hosts/waltz/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit inputs sessionVariables;
            tmux = self.packages.${system}.tmux;
            helix = self.packages.${system}.helix;
            alacritty = self.packages.${system}.alacritty;
            mango = self.packages.${system}.mango;
            xdg = self.packages.${system}.xdg;
            git = self.packages.${system}.git;
            zsh = self.packages.${system}.zsh-wrapper;
            gh = self.packages.${system}.gh;
            qs = inputs.quickshell.packages.${system}.qs;
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
