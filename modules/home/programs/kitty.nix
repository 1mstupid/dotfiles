{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Caskaydia Nerd Font";
      size = 12;
    };

    settings = {
      # Keep Kitty's normal config separate from the generated theme.
      config_dir = "~/.config/kitty";

      # Window appearance
      window_padding_width = 8;
      placement_strategy = "center";
      hide_window_decorations = "no";

      # Dynamic theme reload
      include = "~/.config/kitty/current-theme.conf";

      # Clipboard
      copy_on_select = false;

      # Scrollback
      scrollback_lines = 10000;
    };
    extraConfig = ''
      map f11 toggle_fullscreen

      map ctrl+shift+page_up change_font_size all +1.0
      map ctrl+shift+page_down change_font_size all -1.0
      map ctrl+shift+home change_font_size all 0

      map ctrl+shift+c copy_to_clipboard
      map ctrl+shift+v paste_from_clipboard
    '';
  };
}
