
{...}: {
  flake.nixosModules.i2pd = { ... }: {
    containers.i2pd-container = {
      autoStart = true;

      config = { ... }: {
        system.stateVersion = "23.05";
        networking.firewall.allowedTCPPorts = [
          7656
          7070
          4447
          4444
        ];
        services.i2pd = {
          enable = true;

          settings = {
            http.enabled = true;
            httpproxy.enabled = true;
            socksproxy.enabled = true;
            sam.enabled = false;
          };
        };
      };
    };
  };
}
