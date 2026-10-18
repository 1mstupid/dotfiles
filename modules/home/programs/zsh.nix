
{ config, inputs, ... }:

let
  sessionVariables = config.flake.session;
in
{
  flake.homeModules.zsh = { config, pkgs, ... }: {
    home.packages = [
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.zsh
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages.zsh =
      let
        homeDirectory = "/home/waltz";

        sessionVariablesZsh =
          lib.concatStringsSep "\n"
            (lib.mapAttrsToList
              (name: value:
                "export ${name}=${lib.escapeShellArg value}")
              sessionVariables);
      in
      inputs.wrappers.wrappers.zsh.wrap {
        inherit pkgs;

        runtimePkgs = with pkgs; [
          fzf
          zoxide
          broot
          nh
        ];

        zshAliases = {
          config = "hx ~/dotfiles/hosts/waltz/configuration.nix";
          ns = "nix search nixpkgs";
          nsh = "nix-shell -p";
          hm = "hx ~/dotfiles/modules/home/home.nix";
          flake = "hx ~/dotfiles/flake.nix";
          br = "broot";

          rebuild =
            "git -C ~/dotfiles add .; "
            + "git -C ~/dotfiles commit -m 'minor'; "
            + "nh os switch";
        };

        zshrc.content = ''
          ${sessionVariablesZsh}

          setopt autocd

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
