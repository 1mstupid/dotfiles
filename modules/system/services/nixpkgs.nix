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

}
