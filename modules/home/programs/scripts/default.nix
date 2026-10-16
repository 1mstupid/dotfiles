{
  flake.homeModules.scripts =
    { lib, pkgs, ... }:
    let
      scriptNames = [
        "network"
        "record"
        "screenshot"
        "wallpaper-theme"
      ];

      scripts = pkgs.runCommand "personal-scripts" { } ''
        for script in ${lib.escapeShellArgs scriptNames}; do
          install -Dm755 "${./bin}/$script" "$out/bin/$script"
        done
      '';
    in
    {
      home.packages = [ scripts ];
    };
}
