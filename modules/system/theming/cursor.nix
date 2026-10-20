{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.bibataCursors = {
    pkgs,
    lib,
    ...
  }: let
  in {
    fonts.packages = with pkgs.nerd-fonts; [
      fira-mono
      maple-mono.NL-NF
    ];
    environment.systemPackages = with pkgs; [
      bibata-cursors
    ];

    environment.variables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "20";
    };

    programs.dconf.profiles.user.databases = [
      {
        lockAll = false;
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "Bibata-Modern-Classic";
            font-name = "FiraMono Nerd Font 11";
          };
        };
      }
    ];
  };
}
