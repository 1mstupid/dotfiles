{ pkgs, inputs, config, ... }:
let
  qs = inputs.quickshell.packages.${pkgs.system}.default;
in
{
  home-manager.users.waltz.systemd = {
    quickshell = {
      description = "Quickshell";

      wantedBy = [ "mango-session.target" ];
      partOf = [ "mango-session.target" ];

      serviceConfig = {
        ExecStart = "${qs}/bin/qs";
        WorkingDirectory = "%h";
        Restart = "on-failure";
      };
    };
  };
}

