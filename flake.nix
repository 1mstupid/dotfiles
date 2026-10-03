{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
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
