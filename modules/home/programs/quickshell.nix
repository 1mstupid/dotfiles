{ pkgs, inputs, ... }:

let
  qs = inputs.quickshell.packages.${pkgs.system}.default;
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
      ExecStart = "${qs}/bin/quickshell";
      WorkingDirectory = "%h";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "mango-session.target" ];
    };
  };
}
