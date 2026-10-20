{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.desktop = moduleWithSystem ({pkgs, ...}: let
    modules = with self.nixosModules; [
      network
      quickshell
      sessions
      audio
      helium
      umbriel
      sddm
      network
    ];
  in {
    imports = modules;
    environment.systemPackages = with pkgs; [
      feh
      awww
      wf-recorder
      grim
      zenity
      slurp
      wl-clipboard
      wlsunset
    ];
  });
}
