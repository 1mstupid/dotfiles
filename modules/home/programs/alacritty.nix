{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;

        import = [
          "${config.home.homeDirectory}/.config/alacritty/current-theme.toml"
        ];
      };
      window = {
        padding = {
          x = 65;
          y = 65;
        };

        dynamic_padding = true;

        decorations = "Full";
      };


      font = {
        normal.family = "CaskaydiaMono Nerd Font Mono";
        bold.family = "CaskaydiaMono Nerd Font Mono";
        italic.family = "CaskaydiaMono Nerd Font Mono";
        bold_italic.family = "CaskaydiaMono Nerd Font Mono";
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
