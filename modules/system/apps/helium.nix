{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.helium-flake.nixosModules.default
  ];

  programs.helium = {
    enable = true;

    package = inputs.helium-flake.packages.${pkgs.system}.default.overrideAttrs (old: {
      preFixup = old.preFixup + ''
        gappsWrapperArgs+=(
          --set XDG_CONFIG_HOME "/home/waltz/.local/share/helium"
        )
      '';
    });

    flags = [
      "--user-data-dir=/home/waltz/.local/share/helium"
      "--ozone-platform-hint=auto"
    ];

    policies = {
      BrowserSignin = 0;
      PasswordManagerEnabled = false;
      SyncDisabled = true;

      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderSearchURL =
        "https://4get.eloy.ar/web?s={searchTerms}";

      ExtensionInstallForcelist = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        "hfjbmagddngcpeloejdejnfgbamkjaeg"
        "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        "nngceckbapebfimnlniiiahkandclblb"
      ];
    };
  };
}
