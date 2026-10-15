{ ... }:
{
  flake.homeModules.alacritty =
    { config, pkgs, ... }:
    let
      configToml = pkgs.formats.toml { };

      alacrittyConfig = configToml.generate "alacritty.toml" {
        general = {
          live_config_reload = true;

          import = [
            "${config.home.homeDirectory}/.cache/wallpaper-theme/current-theme.toml"
          ];
        };

        terminal.shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };

        window = {
          padding = {
            x = 20;
            y = 15;
          };

          dynamic_padding = true;
          decorations = "Full";
        };

        font = {
          normal.family = "Maple Mono NL NF";
          bold.family = "Maple Mono NL NF";
          italic.family = "Maple Mono NL NF";
          bold_italic.family = "Maple Mono NL NF";
          size = 12.0;
        };

        selection = {
          save_to_clipboard = true;
        };

        keyboard = {
          bindings = [
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

      alacrittyWrapper = pkgs.writeShellApplication {
        name = "alacritty";

        runtimeInputs = [
          pkgs.alacritty
        ];

        text = ''
          exec ${pkgs.alacritty}/bin/alacritty \
            --config-file ${alacrittyConfig} \
            "$@"
        '';
      };
    in
    {
      home.packages = [
        alacrittyWrapper
        pkgs.maple-mono.NL-NF
      ];
    };
}
