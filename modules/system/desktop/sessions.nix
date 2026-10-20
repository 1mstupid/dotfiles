{
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.sessions = moduleWithSystem (
    { pkgs, self', ... }:
    let
      mangoSession = pkgs.runCommand "mango-session" {
        passthru.providedSessions = [ "mango" ];
      } ''
        mkdir -p "$out/share/wayland-sessions"

        cat > "$out/share/wayland-sessions/mango.desktop" <<EOF
        [Desktop Entry]
        Name=Mango
        Comment=Mango Wayland Compositor
        Exec=${self'.packages.mango}/bin/mango
        Type=Application
        DesktopNames=Mango
        EOF
      '';
    in {
      services.displayManager.sessionPackages = [
        mangoSession
      ];

      # Optional: support X11 applications inside Wayland
      programs.xwayland.enable = true;
    }
  );
}
