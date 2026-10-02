{ config, pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    initContent = ''
      PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$ %b"
    '';

    shellAliases = {
      config = "hx ~/dotfiles/hosts/waltz/configuration.nix";
      ns = "nix search nixpkgs";
      hm = "hx ~/dotfiles/home/home.nix";
      flake = "hx ~/dotfiles/flake.nix";
      br = "broot";
      rebuild = "git -C ~/dotfiles add . ; git -C ~/dotfiles commit -m 'minor' ; nh os switch";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }

      {
        name = "fzf-history-search";
        src = pkgs.zsh-fzf-history-search;
      }

      {
        name = "nix-shell";
        src = pkgs.zsh-nix-shell;
      }

      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }

      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
