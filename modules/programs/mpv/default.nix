{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.mpv = moduleWithSystem (
    {self'}: {
      environment.systemPackages = with self'.packages; [
        mpv
      ];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.mpv = inputs.wrappers.wrappers.mpv.wrap {
      inherit pkgs;

      configDir = {
        mpv = {
          enable = true;
          path = "${inputs.mpv}/mpv.conf";
        };

        input = {
          enable = true;
          path = "${inputs.mpv}/input.conf";
        };
      };

      runtimePkgs = with pkgs; [
        yt-dlp
        ffmpeg
      ];
    };
  };
}
