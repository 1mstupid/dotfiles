{ pkgs, inputs, config, ... }:
let
  qs = inputs.quickshell-config.packages.${pkgs.system}.default;
in
{
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
}

