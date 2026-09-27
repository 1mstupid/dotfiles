{ config, lib, pkgs, ... }:

let
  suwayomi-server-preview = pkgs.stdenvNoCC.mkDerivation {
    pname = "suwayomi-server-preview";
    version = "2.3.2363";

    src = pkgs.fetchurl {
      url = "https://github.com/Suwayomi/Suwayomi-Server-preview/releases/download/v2.3.2363/Suwayomi-Server-v2.3.2363.jar";
      hash = "sha256-cl4bg96ljR7ih6UnftUgHHhZRkM3zZKjTkuuYBi86nY=";
    };

    nativeBuildInputs = [
      pkgs.makeWrapper
    ];

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      makeWrapper ${pkgs.jdk21_headless}/bin/java $out/bin/tachidesk-server \
        --add-flags "-Dsuwayomi.tachidesk.config.server.initialOpenInBrowserEnabled=false -jar $src"
    '';

    meta = {
      description = "Suwayomi Server preview";
      homepage = "https://github.com/Suwayomi/Suwayomi-Server-preview";
      license = lib.licenses.mpl20;
      mainProgram = "tachidesk-server";
    };
  };
in
{
  services.suwayomi-server = {
    enable = true;
    package = suwayomi-server-preview;
  };
}
