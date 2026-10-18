{ config, inputs, ... }:

{
  flake.homeModules.hx = { pkgs, inputs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      home.packages = [
        inputs.self.packages.${system}.hx
      ];
    };

  perSystem = { pkgs, ... }:
    let
      configToml = pkgs.formats.toml { };

      config = {
        theme = "base16_transparent";

        keys = {
          insert = {
            "C-[" = "normal_mode";
            "C-b" = [ "select_mode" "move_prev_word_start" ];
            up = "no_op";
            down = "no_op";
            left = "no_op";
            right = "no_op";
            pageup = "no_op";
            pagedown = "no_op";
            home = "no_op";
            end = "no_op";
            "C-space" = "completion";
          };

          normal = {
            f = [ "goto_line_start" "kill_to_line_end" ];
            p = ":clipboard-paste-replace";
            y = "yank_to_clipboard";
            C-c = [ "select_all" "yank_to_clipboard" ];
            C-v = "vsplit";
            C-h = "jump_view_left";
            C-q = ":quit";
            C-t = ":write";
            C-j = "jump_view_down";
            C-k = "jump_view_up";
            C-l = "jump_view_right";
            "C-," = "goto_previous_buffer";
            "C-." = "goto_next_buffer";
            K = "insert_newline";

            "A-k" = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_up"
              "paste_before"
            ];

            "A-j" = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_down"
              "paste_before"
            ];

            space = {
              "/" = "toggle_comments";
            };
          };

          select = {
            p = ":clipboard-paste-replace";
            y = "yank_to_clipboard";
            d = "delete_selection";
            C-c = [ "yank_to_clipboard" ];

            space = {
              v = ":clipboard-paste-replace";
              "/" = "toggle_comments";
              c = "yank_to_clipboard";
            };
          };
        };

        editor = {
          statusline = {
            left = [
              "mode"
              "separator"
              "file-name"
              "spacer"
              "version-control"
              "spacer"
              "spinner"
            ];

            center = [ ];

            right = [
              "diagnostics"
              "selections"
              "position"
            ];

            separator = "┃";

            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };

          auto-format = false;
          scroll-lines = 6;

          inline-diagnostics.cursor-line = "disable";
          end-of-line-diagnostics = "disable";

          lsp.enable = false;

          indent-guides = {
            render = true;
            character = "╎";
            skip-levels = 0;
          };

          cursor-shape = {
            normal = "block";
            insert = "underline";
            select = "bar";
          };
        };
      };

      configFile = configToml.generate "helix-config.toml" config;
    in
    {
      packages.hx = pkgs.writeShellApplication {
        name = "hx";

        runtimeInputs = [
          pkgs.helix
        ];

        text = ''
          exec ${pkgs.helix}/bin/hx \
            --config ${configFile} \
            "$@"
        '';
      };
    };
}
