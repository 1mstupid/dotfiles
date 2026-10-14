{ config, ... }:

let
  ghosttyPackage = { pkgs, homeDirectory, zsh }:
    let
      ghosttyConfig = pkgs.writeText "config.ghostty" ''
        config-file = ?${homeDirectory}/.cache/wallpaper-theme/current-theme.ghostty
        confirm-close-surface = false

        command = ${zsh}/bin/zsh

        window-padding-x = 65
        window-padding-y = 65
        window-padding-balance = true
        window-decoration = true
        window-padding-color = extend

        font-family = Sarasa Fixed Slab K
        font-family-bold = Sarasa Fixed Slab K
        font-family-italic = Sarasa Fixed Slab K
        font-family-bold-italic = Sarasa Fixed Slab K
        font-size = 13

        copy-on-select = clipboard

        keybind = clear
        keybind = ctrl+shift+plus=increase_font_size:1
        keybind = ctrl+shift+minus=decrease_font_size:1
        keybind = ctrl+shift+home=reset_font_size
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+r=reload_config
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = shift+page_up=scroll_page_up
        keybind = shift+page_down=scroll_page_down
        keybind = f11=toggle_fullscreen

        app-notifications = no-clipboard-copy, no-config-reload
      '';
    in
    pkgs.writeShellApplication {
      name = "ghostty";

      runtimeInputs = [
        pkgs.ghostty
        pkgs.maple-mono.NL-NF
      ];

      text = ''
        exec ${pkgs.ghostty}/bin/ghostty \
          --config-file=${ghosttyConfig} \
          "$@"
      '';
    };

in
{
  flake.homeModules.ghostty = { pkgs, ... }:
    let
      host = config.flake.hosts.waltz;

      ghostty = ghosttyPackage {
        inherit pkgs;
        homeDirectory = host.homeDirectory;
        zsh = pkgs.zsh;
      };
    in
    {
      home.packages = [ ghostty ];
    };
}
