{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;

        import = [
          "${config.home.homeDirectory}/alacritty/current-theme.toml"
        ];
      };
      window = {
        padding = {
          x = 25;
          y = 15;
        };

        dynamic_padding = true;

        decorations = "Full";
      };


      font = {
        normal.family = "Caskaydia Nerd Font Mono";
        bold.family = "Caskaydia Nerd Font Mono";
        italic.family = "Caskaydia Nerd Font Mono";
        bold_italic.family = "Caskaydia Nerd Font Mono";
        size = 12.0;
      };

      selection.save_to_clipboard = true;

      keyboard.bindings = [
        {
          key = "PageUp";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }
        {
          key = "PageDown";
          mods = "Control|Shift";
          action = "DecreaseFontSize";
        }
        {
          key = "Home";
          mods = "Control|Shift";
          action = "ResetFontSize";
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "PageUp";
          mods = "Shift";
          action = "ScrollPageUp";
        }
        {
          key = "PageDown";
          mods = "Shift";
          action = "ScrollPageDown";
        }
        {
          key = "F11";
          action = "ToggleFullscreen";
        }
      ];
    };
  };
}
