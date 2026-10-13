{
  description = "Actually, you're the mistake - Yourself 13/10";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    umbriel = {
      type = "git";
      url = "https://github.com/noctalia-dev/umbriel";
    };

    claude-desktop = {
      type = "github";
      owner = "caverav";
      repo = "claude-desktop-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ranma = {
      type = "github";
      owner = "masshirodev";
      repo = "ranma";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    # nerv-boot = {
    #   type = "git";
    #   url = "https://codeberg.org/GuillotineMelody/nervboot";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-cachyos-kernel = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      ref = "release";
      flake = true;
    };

    quickshell = {
      type = "github";
      owner = "1mstupid";
      repo = "quickshell-config";
    };

    mpv = {
      type = "github";
      owner = "1mstupid";
      repo = "mpv";
    };

    zapfast = {
      type = "github";
      owner = "crmne";
      repo = "zapfast";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-flake = {
      type = "github";
      owner = "oxcl";
      repo = "nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers = {
      type = "github";
      owner = "BirdeeHub";
      repo = "nix-wrapper-modules";
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
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
