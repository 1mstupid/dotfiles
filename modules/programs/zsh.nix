{ pkgs, theme ? "", viMode ? true }:

let
  # These correspond directly to the plugins from the original
  # programs.zsh.plugins configuration.
  plugins = [
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "fzf-tab.plugin.zsh";
    }

    {
      name = "fzf-history-search";
      src = pkgs.zsh-fzf-history-search;
      file = "zsh-fzf-history-search.plugin.zsh";
    }

    {
      name = "nix-shell";
      src = pkgs.zsh-nix-shell;
      file = "nix-shell.plugin.zsh";
    }

    {
      name = "fast-syntax-highlighting";
      src = pkgs.zsh-fast-syntax-highlighting;
      file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
    }
  ] ++ pkgs.lib.optional viMode {
    name = "vi-mode";
    src = pkgs.zsh-vi-mode;
    file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
  };

  # Reproduce the important part of Home Manager's plugin handling:
  # each plugin gets a stable directory and the configured entry file
  # is sourced from the Nix store.
  pluginSources =
    pkgs.lib.concatMapStringsSep "\n" (plugin: ''
      source ${plugin.src}/${plugin.file}
    '') plugins;

  zshrc = pkgs.writeText "zshrc" ''
    # ==========================================================================
    # Options
    # ==========================================================================

    setopt autocd

    # ==========================================================================
    # Oh My Zsh
    # ==========================================================================

    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"

    # Same as:
    #
    # programs.zsh.oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" ];
    # };

    plugins=(
      git
    )

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
    # Completion
    # ==========================================================================

    autoload -Uz compinit
    compinit

    # ==========================================================================
    # zoxide
    # ==========================================================================

    eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

    # ==========================================================================
    # User plugins
    # ==========================================================================

    ${pluginSources}

    # ==========================================================================
    # fzf-tab
    # ==========================================================================

    # fzf-tab's completion UI is activated by normal completion (Tab).
    #
    # These are fzf-tab's group-navigation bindings.
    zstyle ':fzf-tab:*' switch-group '<' '>'

    # ==========================================================================
    # zsh-fzf-history-search
    # ==========================================================================

    # The plugin itself installs Ctrl-R.
    # Its upstream default is ^r.
    #
    # Do not overwrite it with a guessed widget name.

    # ==========================================================================
    # fast-syntax-highlighting
    # ==========================================================================

    # Must be loaded after the widgets/plugins it highlights.
    #
    # This is intentionally near the end of .zshrc.

    # ==========================================================================
    # zsh-vi-mode
    # ==========================================================================

    ${pkgs.lib.optionalString viMode ''
      # zsh-vi-mode manages its own viins/vicmd keymaps.
      #
      # Don't use ordinary bindkey commands here to overwrite those maps.
      # The plugin itself installs Escape/C-[ handling.
    ''}
  '';

  # This is the crucial part:
  #
  # Zsh reads $ZDOTDIR/.zshrc itself.
  #
  # We therefore make the generated zshrc the actual startup file instead
  # of sourcing it and subsequently launching a second, unconfigured zsh.
  zdotdir = pkgs.runCommand "zsh-zdotdir" {} ''
    mkdir -p "$out"
    ln -s ${zshrc} "$out/.zshrc"
  '';

in
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = [
    pkgs.zsh
    pkgs.fzf
    pkgs.zoxide
  ];

  text = ''
    export ZDOTDIR="${zdotdir}"

    exec ${pkgs.zsh}/bin/zsh "$@"
  '';
}
