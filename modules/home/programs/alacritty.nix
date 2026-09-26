{config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = true;

        import = [
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

        size = 13.0;
      };
    };
  };
}
