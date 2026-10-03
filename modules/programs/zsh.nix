{ pkgs }:

let
  zshrc = pkgs.writeText "zshrc" ''
    # ---------------------------------------------------------------------------
    # Options
    # ---------------------------------------------------------------------------

    setopt autocd
    setopt glob_dots

    # ---------------------------------------------------------------------------
    # Prompt
    # ---------------------------------------------------------------------------

    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$ %b"

    # ---------------------------------------------------------------------------
    # Aliases
    # ---------------------------------------------------------------------------

    alias config="hx ~/dotfiles/hosts/waltz/configuration.nix"
    alias ns="nix search nixpkgs"
    alias hm="hx ~/dotfiles/home/home.nix"
    alias flake="hx ~/dotfiles/flake.nix"
    alias br="broot"
    alias rebuild="git -C ~/dotfiles add .; git -C ~/dotfiles commit -m 'minor'; nh os switch"

    # ---------------------------------------------------------------------------
    # zoxide
    # ---------------------------------------------------------------------------

    eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

    # ---------------------------------------------------------------------------
    # Completion
    # ---------------------------------------------------------------------------

    autoload -Uz compinit
    compinit

    # fzf-tab
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

    # fzf-tab configuration
    zstyle ':completion:*' menu no
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

    # Ctrl-Space  -> select multiple
    # F1 / F2     -> switch groups
    # /           -> continuous completion
    # Tab         -> accept completion
    zstyle ':fzf-tab:*' fzf-flags \
      --bind=tab:accept

    # < / > switch between completion groups
    zstyle ':fzf-tab:*' switch-group '<' '>'

    # ---------------------------------------------------------------------------
    # fzf history search
    # ---------------------------------------------------------------------------

    source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

    # Default: Ctrl-R
    export ZSH_FZF_HISTORY_SEARCH_BIND='^R'

    # ---------------------------------------------------------------------------
    # Nix shell integration
    # ---------------------------------------------------------------------------

    source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

    # ---------------------------------------------------------------------------
    # Fast syntax highlighting
    # ---------------------------------------------------------------------------

    source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

    # ---------------------------------------------------------------------------
    # Vi mode
    # ---------------------------------------------------------------------------

    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

    # Escape / Ctrl-[ -> Normal mode
    export ZVM_VI_ESCAPE_BINDKEY='^['

    # Keep plugins working with zsh-vi-mode.
    # zsh-vi-mode initializes its keymaps after startup.
    function zvm_after_lazy_keybindings() {
      # Insert mode
      bindkey -M viins '^R' fzf-history-widget

      # fzf-tab
      bindkey -M viins '^I' expand-or-complete
    }

    # ---------------------------------------------------------------------------
    # Custom vi bindings
    # ---------------------------------------------------------------------------

    # Ctrl-[ is handled by zsh-vi-mode.
    bindkey -M viins '^[' vi-cmd-mode

    # Useful insert-mode bindings
    bindkey -M viins '^A' beginning-of-line
    bindkey -M viins '^E' end-of-line

    # ---------------------------------------------------------------------------
    # Oh My Zsh git plugin functionality
    # ---------------------------------------------------------------------------

    # Git plugin aliases/functionality is provided manually here because this
    # wrapper is not loading Home Manager's programs.zsh.oh-my-zsh module.
    if [[ -f ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh ]]; then
      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
    fi
  '';

in
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = with pkgs; [
    zsh
    zoxide
    fzf
    git
  ];

  text = ''
    exec ${pkgs.zsh}/bin/zsh \
      --rcs \
      --interactive \
      -d \
      -c 'source ${zshrc}; exec zsh -i' \
      "$@"
  '';
}
