{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";
  nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://ayugram-desktop.cachix.org"
      ];
      extra-substituters = ["https://tg-owt.cachix.org"];
      extra-trusted-public-keys = [
        "tg-owt.cachix.org-1:lp0BukIhSK3EIyLcDhDZ5zABgT48nmNp6t4SnZ0wr8w="
      ];

      trusted-public-keys = [
        "ayugram-desktop.cachix.org-1:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="
      ];

      cores = 0;
      max-jobs = 4;
      eval-cache = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nerv-boot = {
      url = "git+https://codeberg.org/GuillotineMelody/nervboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-cachyos-kernel = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      ref = "release";
      flake = true;
    };

    quickshell.url = "github:1mstupid/quickshell-config";

    mpv.url = "github:1mstupid/mpv";

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ayugram-desktop = {
      url = "github:ndfined-crp/ayugram-desktop";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./flake/packages.nix
        ./flake/nixos.nix
        ./flake/home-manager.nix
      ];
    };
}
