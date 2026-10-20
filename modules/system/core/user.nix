{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user = {
    pkgs,
    lib,
    ...
  }: let
    modules = with self.nixosModules; [
      zsh
    ];
  in {
    imports = modules;
    users.users.waltz = {
      isNormalUser = true;
      initialPassword = "asdf";
      shell = pkgs.zsh;
      extraGroups = [
        "root"
        "seat"
        "audio"
        "video"
        "wheel"
        "plugdev"
        "networkmanager"
      ];
    };
  };
}
