{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.ent = moduleWithSystem ({pkgs, ...}: let
    modules = with self.nixosModules; [
      ncmpcpp
      mpv
      media
    ];
  in {
    imports = modules;
    environment.systemPackages = with pkgs; [
      yt-dlp
      sound-theme-freedesktop
    ];
  });
}
