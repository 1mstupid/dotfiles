{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "solyn";

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

    languages = {
      language = [
        {
          name = "rust";
          scope = "source.rust";
          auto-format = true;
        }

        {
          name = "c";
          scope = "source.c";
          auto-format = true;
        }

        {
          name = "cpp";
          scope = "source.cpp";
          auto-format = true;
        }

        {
          name = "python";
          scope = "source.python";
          auto-format = true;
        }

        {
          name = "toml";
          scope = "source.toml";
          auto-format = true;
        }
      ];
    };
  };

}
