{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  pname = "vxwm";
  version = "2.2";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    pkg-config
    ncurses
  ];

  buildInputs = with pkgs; [
    libX11
    libXft
    libXinerama
    imlib2
    fontconfig
  ];

  preBuild = ''
    cp config.def.h config.h
  '';

  preInstall = ''
    export TERMINFO=$out/share/terminfo
    mkdir -p $TERMINFO
  '';

  installFlags = [ "PREFIX=$(out)" ];
}
