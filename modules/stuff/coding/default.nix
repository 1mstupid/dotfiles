{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.coding = moduleWithSystem ({pkgs, ...}: let
    modules = with self.nixosModules; [
      git
      tmux
      hx
      alacritty
    ];
  in {
    imports = modules;
    environment.systemPackages = with pkgs; [
      yazi
      devenv
      gh
      fd
      fzf
      jq
      nvd
      nix-output-monitor
    ];
  });
}
