{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;

  quickshell = inputs.quickshell.packages.${system}.default;

  mangoConfig = pkgs.writeText "mango.conf" ''
    # ...

    # Bind
    bind=SUPER,Return,spawn,alacritty

    bind=SUPER,t,spawn,quickshell ipc call applauncher toggle
    bind=SUPER,b,spawn,quickshell ipc call network toggle
    bind=SUPER+SHIFT,p,spawn,quickshell ipc call powermenu toggle

    # ...

    # Autostart
    exec=quickshell
    exec=awww-daemon

    # ...
  '';

  mango = pkgs.writeShellApplication {
    name = "mango";

    runtimeInputs = [
      pkgs.mango
      quickshell
      pkgs.awww
    ];

    text = ''
      export XDG_CURRENT_DESKTOP=Mango
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=Mango

      exec ${pkgs.mango}/bin/mango -c ${mangoConfig} "$@"
    '';
  };
in
{
  home.packages = [
    mango
    quickshell
    pkgs.awww
  ];
}
