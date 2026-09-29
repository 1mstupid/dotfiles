{ config, pkgs, ... }:

{
  programs.mango.enable = true;
  # programs.niri.enable = true;
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  #   withUWSM = true;
  # };
  systemd.user.services = {
    awww = {
      description = "awww wallpaper daemon";

      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.awww}/bin/awww-daemon";
        Restart = "on-failure";
      };
    };

    quickshell = {
      description = "Quickshell";

      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.quickshell}/bin/quickshell";
        Restart = "on-failure";
      };
    };

    udiskie = {
      description = "udiskie automounter";

      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie";
        Restart = "on-failure";
      };
    };
  };

}
