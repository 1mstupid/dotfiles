{ pkgs, inputs, ... }:

let
  qs = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.qs;
in
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
    qs

    (pkgs.writeShellScriptBin "mango-session" ''
      export XDG_CURRENT_DESKTOP=Mango
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=Mango

      # Start everything belonging to the Mango graphical session.
      systemctl --user start mango-session.target

      # mango is your wrapper from ./mango.nix, so this also
      # supplies the generated mango.conf.
      exec mango
    '')
  ];

  systemd.user.targets.mango-session = {
    description = "Mango graphical session";

    wants = [
      "awww.service"
      "quickshell.service"
    ];
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

      serviceConfig = {
        ExecStart = "${qs}/bin/qs";
        WorkingDirectory = "%h";
        Restart = "on-failure";
        RestartSec = "1s";
      };
    };
  };
}
