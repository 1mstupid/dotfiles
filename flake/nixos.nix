{ inputs, ... }:

{
  flake.nixosConfigurations.nixos-btw =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs =
        let
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
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

          programs = import ../modules/programs {
            inherit pkgs inputs homeDirectory sessionVariables;
          };
        in
        {
          inherit inputs programs sessionVariables;
        };

      modules = [
        ../hosts/waltz/configuration.nix

        inputs.home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit programs sessionVariables;
          };

          home-manager.users.waltz = {
            imports = [
              ../modules/home/home.nix
            ];
          };
        }
      ];
    };
}
