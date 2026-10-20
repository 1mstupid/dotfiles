{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.comms = moduleWithSystem ({pkgs, inputs', ...}: let
    modules = with self.nixosModules; [

    ];
  in {
    imports = modules;
    environment.systemPackages = with pkgs; [
      inputs'.ayugram-desktop.packages.default
      inputs'.zapfast.packages.default
    ];
  });
}
