{
  description = "You're dead.";
  inputs = {
    # system
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    nix-cachyos-kernel = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      ref = "release";
      flake = true;
    };

    # applications
    umbriel-config = {
      type = "github";
      owner = "1mstupid";
      repo = "umbriel-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    umbriel = {
      url = "github:noctalia-dev/umbriel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      type = "github";
      owner = "1mstupid";
      repo = "quickshell-config";
      flake = false;
    };
    mpv = {
      type = "github";
      owner = "1mstupid";
      repo = "mpv";
    };
    sls-steam.url = "github:AceSLS/SLSsteam";
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

    # flake-parts 
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
    };
    wrappers = {
      type = "github";
      owner = "BirdeeHub";
      repo = "nix-wrapper-modules";
    };
    import-tree = {
      type = "github";
      owner = "denful";
      repo = "import-tree";
    }; 
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
      (inputs.import-tree ./modules);
}
