
{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.tmux = moduleWithSystem (
    {self'}: {
      environment.systemPackages = with self'.packages; [
        tmux
      ];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.tmux =
      let
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
            set -g mouse off

            # Prefix
            bind-key -T prefix C-b switch-client -T prefix
            bind-key -T prefix Escape switch-client -T root

            # Sticky prefix
            bind-key C-b switch-client -T sticky
            bind-key -T sticky Escape switch-client -T root
            bind-key -T sticky C-b switch-client -T sticky

            # Pane navigation
            bind-key -T sticky h select-pane -L \; switch-client -T sticky
            bind-key -T sticky j select-pane -D \; switch-client -T sticky
            bind-key -T sticky k select-pane -U \; switch-client -T sticky
            bind-key -T sticky l select-pane -R \; switch-client -T sticky

            # Pane splits
            bind-key -T sticky '|' split-window -h \; switch-client -T sticky
            bind-key -T sticky - split-window -v \; switch-client -T sticky

            # Kill current pane
            bind-key -T sticky x kill-pane

            # Close current window
            bind-key -T sticky X kill-window

            # Zoom / unzoom current pane
            bind-key -T sticky z resize-pane -Z \; switch-client -T sticky

            # Swap panes
            bind-key -T sticky H swap-pane -U \; switch-client -T sticky
            bind-key -T sticky L swap-pane -D \; switch-client -T sticky

            # Appearance
            set -g status-position top
            set -g status-interval 5
            set -g status-style 'fg=default bg=default'
            set -g message-style 'fg=default,bg=default'
            set -g message-command-style reverse
            set -g status-left '#{?#{==:#{client_key_table},sticky},#[bg=yellow]#[fg=black] STICKY #[default],} #S '

            set -g status-justify absolute-centre
            setw -g window-status-current-style 'fg=green bold bg=default'
            setw -g window-status-style 'fg=default'
            setw -g window-status-format "#I:#W"
            setw -g window-status-current-format "#I:#W"

            set -g pane-border-lines simple
            set -g pane-border-style fg=colour241
            set -g pane-active-border-style fg=colour39

            # Copy mode
            set-window-option -g mode-keys vi

            bind v copy-mode
            bind -T copy-mode-vi y send -X copy-selection-and-cancel
            bind -T copy-mode-vi v send -X begin-selection
            bind -T copy-mode-vi Escape send -X cancel

            # External
            bind e display-popup
            bind G new-window -n 'lazygit' lazygit

            bind-key b set-option status
          '';
      in
    inputs.wrappers.wrappers.tmux.wrap {
      inherit pkgs;

      addFlag = [
        "-f"
        "${tmuxConf}"
      ];
    };
  };
}
