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

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  homeDirectory = "/home/waltz";

  sessionVariables = {
    NH_FLAKE = "${homeDirectory}/dotfiles";
    GIT_CONFIG_GLOBAL = "${homeDirectory}/.local/state/git/config";
    GH_CONFIG_DIR = "${homeDirectory}/.local/state/gh";
    EDITOR = "hx";
    QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
    VISUAL = "hx";
    BROWSER = "helium";
  };

  programs = import ../modules/home/programs {
    inherit pkgs inputs homeDirectory sessionVariables;
  };
in
{
  flake.nixosConfigurations.nixos-btw =
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs programs sessionVariables;
      };

      modules = [
        ../hosts/waltz/configuration.nix

        inputs.umbriel.nixosModules.default
        inputs.home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit programs sessionVariables inputs;
          };

          home-manager.users.waltz = {
            imports = [
              config.flake.homeModules.default
              config.flake.homeModules.alacritty
            ];
          };
        }
      ];
    };
}
