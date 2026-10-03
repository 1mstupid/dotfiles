{ pkgs, theme ? "", viMode ? true }:

let
  zshPlugins = {
    fzf-tab = {
      src = pkgs.zsh-fzf-tab;
      file = "fzf-tab.plugin.zsh";
    };

    fzf-history-search = {
      src = pkgs.zsh-fzf-history-search;
      file = "zsh-fzf-history-search.plugin.zsh";
    };

    nix-shell = {
      src = pkgs.zsh-nix-shell;
      file = "nix-shell.plugin.zsh";
    };

    fast-syntax-highlighting = {
      src = pkgs.zsh-fast-syntax-highlighting;
      file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
    };

    vi-mode = {
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    };
  };

  plugin = name:
    let
      p = zshPlugins.${name};
    in
    "${p.src}/${p.file}";

  zshrc = pkgs.writeText "zshrc" ''
    # ==========================================================================
    # Zsh
    # ==========================================================================

    setopt autocd

    # ==========================================================================
    # Oh My Zsh
    # ==========================================================================

    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"

    # Keep the git plugin from the original Home Manager configuration.
    plugins=(
      git
    )

    # Don't let OMZ install/update anything.
    export DISABLE_AUTO_UPDATE=true
    export DISABLE_UPDATE_PROMPT=true

    source "$ZSH/oh-my-zsh.sh"

    # ==========================================================================
    # Prompt
    # ==========================================================================

    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$ %b"

    # ==========================================================================
    # Aliases
    # ==========================================================================

    alias config="hx ~/dotfiles/hosts/waltz/configuration.nix"
    alias ns="nix search nixpkgs"
    alias hm="hx ~/dotfiles/home/home.nix"
    alias flake="hx ~/dotfiles/flake.nix"
    alias br="broot"
    alias rebuild="git -C ~/dotfiles add .; git -C ~/dotfiles commit -m 'minor'; nh os switch"

    # ==========================================================================
    # zoxide
    # ==========================================================================

    eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

    # ==========================================================================
    # Completion
    # ==========================================================================

    autoload -Uz compinit
    compinit

    # ==========================================================================
    # fzf-tab
    #
    # This is loaded after completion, like a normal zsh plugin.
    # ==========================================================================

    source ${plugin "fzf-tab"}

    # ==========================================================================
    # fzf history search
    #
    # The plugin itself installs Ctrl-R. Do NOT manually bind Ctrl-R to some
    # guessed widget name.
    # ==========================================================================

    source ${plugin "fzf-history-search"}

    # ==========================================================================
    # nix-shell
    # ==========================================================================

    source ${plugin "nix-shell"}

    # ==========================================================================
    # Fast syntax highlighting
    #
    # This needs to be loaded after widgets/functions have been defined.
    # ==========================================================================

    source ${plugin "fast-syntax-highlighting"}

    ${pkgs.lib.optionalString viMode ''
      # ========================================================================
      # zsh-vi-mode
      # ========================================================================

      # zsh-vi-mode has its own keymap initialization. Load it last so it can
      # establish its viins/vicmd maps without being overwritten by plugins.
      source ${plugin "vi-mode"}
    ''}

    # ==========================================================================
    # Plugin configuration
    # ==========================================================================

    # fzf-tab
    zstyle ':fzf-tab:*' switch-group '<' '>'

    # fzf-tab: don't replace the normal completion menu with another zsh menu.
    zstyle ':completion:*' menu no

    # ==========================================================================
    # zsh-vi-mode integration
    # ==========================================================================

    ${pkgs.lib.optionalString viMode ''
      # Initialize fzf's shell integration after zsh-vi-mode has established
      # its keymaps.
      if (( $+commands[fzf] )); then
        zvm_after_init_commands+=(eval "$(fzf --zsh)")
      fi
    ''}
  '';

in
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = with pkgs; [
    zsh
    fzf
    zoxide
  ];

  text = ''
    exec ${pkgs.zsh}/bin/zsh \
      -d \
      -i \
      -c 'source ${zshrc}; exec zsh -i' \
      "$@"
  '';
}
