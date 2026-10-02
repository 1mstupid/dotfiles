{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.helium-flake.nixosModules.default
  ];

  programs.helium = {
    enable = true;

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
