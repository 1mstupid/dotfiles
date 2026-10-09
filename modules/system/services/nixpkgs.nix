{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://ayugram-desktop.cachix.org"
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

}
