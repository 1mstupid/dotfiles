{ ... }:
{
  flake.homeModules.tmux =
  { pkgs, ... }:

  let
    tmuxPlugins = pkgs.tmuxPlugins;

    tmuxConf = pkgs.writeText "tmux.conf" ''
      set -s default-terminal "tmux-256color"

      set -as terminal-features ',alacritty:RGB:clipboard,alacritty*:RGB:clipboard,xterm-kitty:RGB:clipboard'
      set -sg terminal-overrides ",*:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%d'

      set -g allow-passthrough on
      set-option -s extended-keys on
      set -g extended-keys-format csi-u

      set -g renumber-windows on
      set -g allow-rename on
      set -g set-clipboard on

      # keymap general
      set -g prefix C-Space
      unbind C-b
      bind C-Space send-prefix

      # sticky mode
      bind C-Space switch-client -T sticky
      bind -T sticky Escape switch-client -T root
      bind -T sticky c new-window -c "#{pane_current_path}" \; switch-client -T sticky

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

      # Navigate panes (useful when you do split)
      bind -T sticky h select-pane -L \; switch-client -T sticky
      bind -T sticky j select-pane -D \; switch-client -T sticky
      bind -T sticky k select-pane -U \; switch-client -T sticky
      bind -T sticky l select-pane -R \; switch-client -T sticky

      # Workspaces = windows
      bind -T sticky c new-window \; switch-client -T sticky
      bind -T sticky n next-window \; switch-client -T sticky
      bind -T sticky p previous-window \; switch-client -T sticky
      bind -T sticky 0 select-window -t 0 \; switch-client -T sticky
      bind -T sticky 1 select-window -t 1 \; switch-client -T sticky
      bind -T sticky 2 select-window -t 2 \; switch-client -T sticky
      bind -T sticky 3 select-window -t 3 \; switch-client -T sticky
      bind -T sticky 4 select-window -t 4 \; switch-client -T sticky
      bind -T sticky 5 select-window -t 5 \; switch-client -T sticky

      # Rename current workspace
      bind -T sticky , command-prompt -I "#{window_name}" \
        "rename-window '%%' \; switch-client -T sticky"

      # Close current workspace
      bind -T sticky x kill-window \; switch-client -T sticky

      # copy mode
      set-window-option -g mode-keys vi

      bind v copy-mode
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi Escape send -X cancel

      # external
      bind e display-popup
      bind G new-window -n 'lazygit' lazygit

      bind-key b set-option status
    '';
  in
  {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "tmux";

        paths = [ pkgs.tmux ];

        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/tmux \
            --add-flags "-f ${tmuxConf}"
        '';
      })
    ];
  };
}
