
{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.ghostty = moduleWithSystem (
    {self'}: {
      home.packages = with self'.packages; [
        ghostty
      ];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.ghostty =
      inputs.wrappers.wrappers.ghostty.wrap {
        inherit pkgs;

        settings = {
          "config-file" = "?/home/waltz/.cache/wallpaper-theme/current-theme.ghostty";
          "confirm-close-surface" = false;

          command = "${pkgs.zsh}/bin/zsh";

          "window-padding-x" = 15;
          "window-padding-y" = 10;
          "window-padding-balance" = true;
          "window-decoration" = true;
          "window-padding-color" = "extend";

          "font-family" = "Maple Mono NL NF";
          "font-family-bold" = "Maple Mono NL NF";
          "font-family-italic" = "Maple Mono NL NF";
          "font-family-bold-italic" = "Maple Mono NL NF";
          "font-size" = 12;

          "copy-on-select" = "clipboard";

          keybind = [
            "clear"
            "ctrl+shift+plus=increase_font_size:1"
            "ctrl+shift+minus=decrease_font_size:1"
            "ctrl+shift+home=reset_font_size"
            "ctrl+shift+c=copy_to_clipboard"
            "ctrl+shift+r=reload_config"
            "ctrl+shift+v=paste_from_clipboard"
            "shift+page_up=scroll_page_up"
            "shift+page_down=scroll_page_down"
            "f11=toggle_fullscreen"
          ];

          "app-notifications" = "no-clipboard-copy, no-config-reload";
        };
      };
  };
}
