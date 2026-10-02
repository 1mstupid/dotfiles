{ pkgs }:

let
  tmuxConf = pkgs.writeText "tmux.conf" ''
    set -s default-terminal "tmux-256color"

    set -sa terminal-features ',xterm-kitty:cstyle,xterm-256color:RGB,tmux-256color:RGB'
    set -sg terminal-overrides ",*:RGB"
    set -as terminal-overrides ',*:Smulx=\E[4::%p1%d'

    set -g allow-passthrough on
    set-option -s extended-keys on
    set -g extended-keys-format csi-u

    set -g renumber-windows on
    set -g allow-rename on
    set -g set-clipboard on

    # keymap general
    bind-key C-SPACE send-prefix
    bind r source-file ${tmuxConf}

    # appearance
    set -g status-position top
    set -g status-interval 5
    set -g status-style 'fg=default bg=default'
    set -g message-style 'fg=default,bg=default'
    set -g message-command-style reverse

    set -g status-justify absolute-centre
    setw -g window-status-current-style 'fg=green bold bg=default'
    setw -g window-status-style 'fg=default'
    setw -g window-status-format "#I:#W"
    setw -g window-status-current-format "#I:#W"

    set -g pane-border-lines simple
    set -g pane-border-style fg=colour241
    set -g pane-active-border-style fg=colour39

    # window management
    set-window-option -g aggressive-resize on

    set-hook -g after-new-window "select-layout main-vertical"
    set-hook -g after-split-window "select-layout main-vertical"

    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R

    bind -n M-k select-pane -U
    bind -n M-j select-pane -D
    bind -n M-h select-pane -L
    bind -n M-l select-pane -R

    bind Enter split-window -h
    bind -n M-Enter split-window -h
    bind t new-window
    bind -n M-t new-window
    bind x kill-pane
    bind -n M-w kill-pane
    bind Q kill-session

    # copy mode
    set-window-option -g mode-keys vi

    bind v copy-mode
    bind -T copy-mode-vi y send -X copy-selection-and-cancel
    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi Escape send -X cancel

    # external
    bind e display-popup
    bind G new-window -n 'lazygit' lazygit

    bind-key f run-shell "tmux neww ~/bin/tmux-sessionizer"
    bind-key u run-shell "~/bin/tmux-sessionizer u"
    bind-key n run-shell "~/bin/tmux-sessionizer ~/org"
    bind-key b set-option status
  '';

in
pkgs.symlinkJoin {
  name = "tmux";

  paths = [ pkgs.tmux ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/tmux \
      --add-flags "-f ${tmuxConf}"
  '';
}
