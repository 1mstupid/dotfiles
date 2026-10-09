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

  environment.etc."xdg/wayland-sessions/umbriel.desktop".text = ''
    [Desktop Entry]
    Name=Umbriel
    Comment=Umbriel Wayland Session
    Exec=umbriel
    Type=Application
    DesktopNames=Umbriel
  '';
}
