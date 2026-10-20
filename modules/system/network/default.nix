{moduleWithSystem, ...}: {
  flake.nixosModules.network = moduleWithSystem (
  {...}: 
  {
    networking.hostName = "waltz";
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    networking.firewall = {
      enable = true;
      allowPing = false;
    };

    networking.nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "true";
        DNSOverTLS = "opportunistic";
        Domains = ["~."];
        FallbackDNS = ["8.8.8.8#dns.google"];
      };
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  }); 
}

