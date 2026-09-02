{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  pname = "st";
  version = "2.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    pkg-config
    ncurses
  ];

  buildInputs = with pkgs; [
    libX11
    libXft
    imlib2
    fontconfig
  ];

  # This ensures we use the config file we actually edited
  preBuild = ''
    cp config.def.h config.h
  '';

  preInstall = ''
    export TERMINFO=$out/share/terminfo
    mkdir -p $TERMINFO
  '';

  installFlags = [ "PREFIX=$(out)" ];
}

