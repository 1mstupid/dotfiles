{config, pkgs, ... }:

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

      font = {
        normal = {
          family = "Caskaydia Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "Caskaydia Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "Caskaydia Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "Caskaydia Nerd Font";
          style = "Bold Italic";
        };

        size = 12.0;
      };

      selection = {
        save_to_clipboard = true;
      };

      keyboard.bindings = [
        # st: TERMMOD + Prior
        {
          key = "PageUp";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }

        # st: TERMMOD + Next
        {
          key = "PageDown";
          mods = "Control|Shift";
          action = "DecreaseFontSize";
        }

        # st: TERMMOD + Home
        {
          key = "Home";
          mods = "Control|Shift";
          action = "ResetFontSize";
        }

        # st: TERMMOD + C / V
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

        # st: Shift + PageUp / PageDown
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

        # st: F11 fullscreen
        {
          key = "F11";
          action = "ToggleFullscreen";
        }
      ];
    };
  };
}
