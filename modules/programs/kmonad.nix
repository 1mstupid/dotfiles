{ pkgs, ... }:
{
    systemd.services.kmonad = {
    description = "KMonad keyboard remapping";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    wants = [ "systemd-udev-settle.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /home/waltz/.config/kmonad/config.kbd";
      Restart = "on-failure";
      RestartSec = 2;
      User = "root";
    };
  };
}
