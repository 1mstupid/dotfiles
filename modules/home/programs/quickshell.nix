{ pkgs, inputs, ... }:

let
  qs = inputs.quickshell.packages.${stdenv.hostPlatform.system}.qs;
in
{
  home.packages = [ qs ];

  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell";
      After = [ "mango-session.target" ];
      PartOf = [ "mango-session.target" ];
    };

    Service = {
      ExecStart = "${qs}/bin/qs";
      WorkingDirectory = "%h";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "mango-session.target" ];
    };
  };
}
