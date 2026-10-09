{ pkgs, homeDirectory, zsh }:

let
  ghosttyConfig = pkgs.writeText "config.ghostty" ''
    # Configuration
    config-file = ?${homeDirectory}/.cache/wallpaper-theme/current-theme.ghostty
    confirm-close-surface = false

    # Shell
    command = ${zsh}/bin/zsh

    # Window
    window-padding-x = 65
    window-padding-y = 65
    window-padding-balance = true
    window-decoration = true
    background-opacity       = 0.8
    background-blur          = true
    background-opacity-cells = true

    window-padding-balance = true
    window-padding-color   = extend

    # Font
    font-family = Maple Mono NL NF
    font-family-bold = Maple Mono NL NF
    font-family-italic = Maple Mono NL NF
    font-family-bold-italic = Maple Mono NL NF
    font-size = 12

    # Clipboard
    copy-on-select = clipboard

    # Keybindings
    # Remove defaults so tmux / Neovim can own their key combinations.
    keybind = clear

    keybind = ctrl+shift+page_up=increase_font_size:1
    keybind = ctrl+shift+page_down=decrease_font_size:1
    keybind = ctrl+shift+home=reset_font_size

    keybind = ctrl+shift+c=copy_to_clipboard
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
}
