{ inputs, moduleWithSystem, ... }:

{
  flake.nixosModules.zsh = moduleWithSystem({ pkgs, self', lib, flakeLocation, ... }:
    {
      nixpkgs.overlays = [
          (final: prev: {
            zsh = self'.packages.zsh;
          })
        ];
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        histSize = 10000;
      };
      users.defaultUserShell = pkgs.zsh;
    });
  perSystem = { self', pkgs, ... }:
    let
      inherit (pkgs) lib;

      homeDirectory = "/home/waltz";
      sessionVariables = {
        NH_FLAKE = "/home/waltz/Projects/nixos";
        EDITOR = "hx";
        VISUAL = "hx";
        BROWSER = "helium";
      };
      sessionVariablesZsh =
        lib.concatStringsSep "\n"
          (lib.mapAttrsToList
            (name: value:
              "export ${name}=${lib.escapeShellArg value}")
            sessionVariables);
    in
  {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;
      zshAliases = {
        cat = lib.getExe pkgs.bat;
        lg = lib.getExe pkgs.lazygit;
        man = "man -P \"${lib.getExe pkgs.bat} -p\"";
        config = "hx ~/dotfiles/hosts/waltz/configuration.nix";
        ns = "nix search nixpkgs";
        nsh = "nix-shell -p";
        hm = "hx ~/dotfiles/modules/home/home.nix";
        flake = "hx ~/dotfiles/flake.nix";
        br = lib.getExe pkgs.broot;
        rebuild = "nh os switch --impure .#nixos-btw";
      };

      zshrc.content = ''
        ${sessionVariablesZsh}

        setopt autocd

        export NH_FLAKE="~/Projects/nixos"
        export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
        export PATH="${homeDirectory}/.cargo/bin:${homeDirectory}/.local/bin:$PATH"

        plugins=(git)

        source "$ZSH/oh-my-zsh.sh"

        PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$ %b"

        eval "$(${lib.getExe pkgs.zoxide} init zsh)"

        autoload -Uz compinit
        compinit

        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
        source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
    };
  };
}
