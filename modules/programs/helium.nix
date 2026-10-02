{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.helium-flake.homeModules.default
  ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--user-data-dir=/home/waltz/.local/share/helium"
    ];

    policies = {
      "BrowserSignin" = 0;                                    # Disable browser signin
      "PasswordManagerEnabled" = false;                        # Disable password manager
      "SyncDisabled" = true;                                  # Disable sync
      "DefaultSearchProviderEnabled" = true;
    };
  };
}
