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
      export XDG_CURRENT_DESKTOP=Mango
      export XDG_SESSION_TYPE=wayland

      exec mango
    '')
  ];

  systemd.user.targets.mango-session = {
    description = "Mango graphical session";

    unitConfig = {
      BindsTo = "graphical-session.target";
      After = "graphical-session.target";
    };
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
        RestartSec = "1s";
      };
    };

    quickshell = {
      description = "Quickshell";

      wantedBy = [ "mango-session.target" ];
      partOf = [ "mango-session.target" ];

      path = with pkgs; [
        bash
        coreutils
        gnugrep
        procps
        networkmanager
        findutils
        util-linux
      ];

      serviceConfig = {
        ExecStart = "${pkgs.quickshell}/bin/quickshell";
        WorkingDirectory = "%h";
        Restart = "on-failure";

        Environment = [
          "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/waltz/bin"
        ];
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
