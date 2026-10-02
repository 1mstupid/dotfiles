{ pkgs }:

let
  helixConfig = pkgs.writeText "config.toml" ''
    theme = "base16_transparent"

    [keys.insert]
    "C-[" = "normal_mode"
    "C-b" = ["select_mode", "move_prev_word_start"]
    up = "no_op"
    down = "no_op"
    left = "no_op"
    right = "no_op"
    pageup = "no_op"
    pagedown = "no_op"
    home = "no_op"
    end = "no_op"
    "C-space" = "completion"

    [keys.normal]
    f = ["goto_line_start", "kill_to_line_end"]
    p = ":clipboard-paste-replace"
    y = "yank_to_clipboard"
    C-c = ["select_all", "yank_to_clipboard"]
    C-v = "vsplit"
    C-h = "jump_view_left"
    C-q = ":quit"
    C-t = ":write"
    C-j = "jump_view_down"
    C-k = "jump_view_up"
    C-l = "jump_view_right"
    "C-," = "goto_previous_buffer"
    "C-." = "goto_next_buffer"
    K = "insert_newline"

    "A-k" = [
      "extend_to_line_bounds",
      "delete_selection",
      "move_line_up",
      "paste_before"
    ]

    "A-j" = [
      "extend_to_line_bounds",
      "delete_selection",
      "move_line_down",
      "paste_before"
    ]

    [keys.normal.space]
    "/" = "toggle_comments"

    [keys.select]
    p = ":clipboard-paste-replace"
    y = "yank_to_clipboard"
    d = "delete_selection"
    C-c = ["yank_to_clipboard"]

    [keys.select.space]
    v = ":clipboard-paste-replace"
    "/" = "toggle_comments"
    c = "yank_to_clipboard"

    [editor]
    auto-format = false
    scroll-lines = 6

    [editor.inline-diagnostics]
    cursor-line = "disable"

    [editor]
    end-of-line-diagnostics = "disable"

    [editor.lsp]
    enable = false

    [editor.indent-guides]
    render = true
    character = "╎"
    skip-levels = 0

    [editor.cursor-shape]
    normal = "block"
    insert = "underline"
    select = "bar"

    [[language]]
    name = "rust"
    scope = "source.rust"
    auto-format = true

    [[language]]
    name = "c"
    scope = "source.c"
    auto-format = true

    [[language]]
    name = "cpp"
    scope = "source.cpp"
    auto-format = true

    [[language]]
    name = "python"
    scope = "source.python"
    auto-format = true

    [[language]]
    name = "toml"
    scope = "source.toml"
    auto-format = true
  '';

in
pkgs.symlinkJoin {
  name = "helix";

  paths = [ pkgs.helix ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/hx \
      --add-flags "--config ${helixConfig}"
  '';
}
