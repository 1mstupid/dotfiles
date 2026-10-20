{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.nixos-btw = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      core
      i2pd
      desktop
      kmonad
      desktopConfig
      amdDrivers
      coding
      ent
      steam
      studies
      comms
      scripts
      sddm-autologin
    ];
  };
}

