{inputs, ...}:
{
  perSystem = {system, ...}: {
    _module.args = {
      unfreePkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstablePkgs = import inputs.nixpkgs-unstable {
        inherit system;
      };
      # Make flakeLocation universally addressable
      flakeLocation = builtins.getEnv "PWD";
    };
  };

  flake.nixosModules.settings = {...}:{
    programs.nh = {
      enable = true;
    };

    nix = {
      settings = {
        substituters = [
          "https://cache.nixos.org"
        ];

        trusted-substituters = [
          "https://ayugram-desktop.cachix.org"
          "https://tg-owt.cachix.org"
        ];

        trusted-public-keys = [
          "ayugram-desktop.cachix.org-1:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="
          "tg-owt.cachix.org-1:lp0BukIhSK3EIyLcDhDZ5zABgT48nmNp6t4SnZ0wr8w="
        ];
        cores = 6;
        eval-cache = true;
        nix-path = ["nixpkgs=${inputs.nixpkgs}"];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };


      optimise.automatic = true;

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 5d";
      };
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
        packageOverrides = pkgs: {
          unstable = import inputs.nixpkgs-unstable {
            config = {
              allowUnfree = true;
            };
          };
        };
      };
    };
  };
}

