{ ... }:

{
  programs.mango.enable = true;

  environment.etc."xdg/wayland-sessions/mango.desktop".text = ''
    [Desktop Entry]
    Name=Mango
    Comment=Mango Wayland Compositor
    Exec=mango
    Type=Application
    DesktopNames=Mango
  '';

  programs.umbriel.enable = true;
}
