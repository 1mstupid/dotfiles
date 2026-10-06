{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wireguard-tools
    iproute2
  ];

  services.transmission = {
    enable = true;
    openFirewall = true;
    user = "waltz";
    group = "users";
    settings = {
      rpc-bind-address = "127.0.0.1";
      rpc-whitelist-enabled = false;
      rpc-enabled = true;
      rpc-port = 9091;
      download-dir = "/srv/downloads/complete";
      incomplete-dir-enabled = true;
      incomplete-dir = "/srv/downloads/incomplete";
      ratio-limit = 2;
      ratio-limit-enabled = true;
    };
  };

  networking.wg-quick.interfaces.protonvpn-sys = {
    configFile = "/etc/wireguard/protonvpn.conf";
    autostart = false;
    dns = ["10.2.0.1"];
  };
}
