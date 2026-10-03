{ pkgs, theme ? "red", viMode ? true }:

let
  zshrc = pkgs.writeText "zshrc" ''
    setopt autocd

    # Prompt
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$ %b"

    # Aliases
    alias config="hx ~/dotfiles/hosts/waltz/configuration.nix"
    alias ns="nix search nixpkgs"
    alias hm="hx ~/dotfiles/home/home.nix"
    alias flake="hx ~/dotfiles/flake.nix"
    alias br="broot"
    alias rebuild="git -C ~/dotfiles add .; git -C ~/dotfiles commit -m 'minor'; nh os switch"

    # zoxide
    eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

    # Completion
    autoload -Uz compinit
    compinit

    # fzf-tab
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

    # fzf-tab keybinds
    zstyle ':fzf-tab:*' switch-group '<' '>'
    zstyle ':fzf-tab:*' fzf-bindings \
      'ctrl-space:toggle+down' \
      'ctrl-a:accept'

    # fzf history search
    source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

    # Ctrl-R = history search
    bindkey '^R' fzf-history-search

    # Nix shell
    source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

    # Fast syntax highlighting
    source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

    ${pkgs.lib.optionalString viMode ''
      # Vi mode
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # Escape / Ctrl-[ -> normal mode
      export ZVM_VI_ESCAPE_BINDKEY='^['
    ''}
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
      -d \
      -i \
      -c 'source ${zshrc}; exec zsh -i' \
      "$@"
  '';
}
