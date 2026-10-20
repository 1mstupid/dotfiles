{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.studies = moduleWithSystem ({pkgs, ...}: let
    modules = with self.nixosModules; [
      anki
    ];
  in {
    imports = modules;
    environment.systemPackages = with pkgs; [
      (symlinkJoin {
          name = "sioyek";
          paths = [ sioyek ];
          nativeBuildInputs = [ makeWrapper ];

          postBuild = ''
            wrapProgram $out/bin/sioyek \
              --prefix LD_LIBRARY_PATH : ${
                lib.makeLibraryPath [ pipewire ]
              }
          '';
      })
    ];
  });
}
