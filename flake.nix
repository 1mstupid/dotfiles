{
  description = "Dummmy, you're making a massive mistake - Yourself 21/08";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    umbriel.url = "git+https://github.com/noctalia-dev/umbriel";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nerv-boot = {
      url = "git+https://codeberg.org/GuillotineMelody/nervboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        type = "git";
        submodules = true;
        url = "https://github.com/ndfined-crp/ayugram-desktop/";
     };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
