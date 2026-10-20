
{
  inputs,
  ...
}: {
  flake.nixosModules.umbriel = { pkgs, ... }: {
    imports = [ inputs.umbriel.nixosModules.default ];

    programs.umbriel = {
      enable = true;
      package =
        inputs.umbriel-config.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    systemd.user.services.umbriel = {
      serviceConfig.ExecStart = pkgs.lib.mkForce [
        ""
        "${inputs.umbriel-config.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/umbriel"
      ];
    };
    services.seatd.enable = true;
    security.polkit.enable = true;
  };
}
