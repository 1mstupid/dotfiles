{ config, pkgs, ... }:

{
  programs.mango.enable = true;

  environment.etc."xdg/wayland-sessions/mango.desktop".text = ''
    [Desktop Entry]
    Name=Mango
    Comment=Mango Wayland Compositor
    Exec=mango-session
    Type=Application
    DesktopNames=Mango
  '';

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mango-session" ''
      systemctl --user start mango-session.target
      exec mango
    '')
  ];

  # programs.niri.enable = true;
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  #   withUWSM = true;
  # };
  systemd.user.targets.mango-session = {
    description = "Mango graphical session";

    unitConfig = {
      BindsTo = "graphical-session.target";
      After = "graphical-session.target";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.user.services = {
    awww = {
      description = "awww wallpaper daemon";

      wantedBy = [ "mango-session.target" ];
      partOf = [ "mango-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.awww}/bin/awww-daemon";
        WorkingDirectory = "%h";
        Restart = "on-failure";
      };
    };

    quickshell = {
      description = "Quickshell";

      wantedBy = [ "mango-session.target" ];
      partOf = [ "mango-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.quickshell}/bin/quickshell";
        WorkingDirectory = "%h";
        Restart = "on-failure";
      };
    };

    udiskie = {
      description = "udiskie automounter";

      wantedBy = [ "mango-session.target" ];
      partOf = [ "mango-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie";
        WorkingDirectory = "%h";
        Restart = "on-failure";
      };
    };
  };

}
