{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.helium-flake.homeModules.default
  ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];

    policies = {
      "BrowserSignin" = 0;                                    # Disable browser signin
      "PasswordManagerEnabled" = false;                        # Disable password manager
      "SyncDisabled" = true;                                  # Disable sync
      "DefaultSearchProviderEnabled" = true;
    };
  };
}
