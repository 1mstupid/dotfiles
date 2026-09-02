{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  pname = "vcompmgr";
  version = "2.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    pkg-config
    ncurses
  ];

  buildInputs = with pkgs; [
    libX11
    libXext
    libXcomposite
    libXfixes
    libXdamage
    libXrender
    libXinerama
    libdrm
  ];

  preInstall = ''
    export TERMINFO=$out/share/terminfo
    mkdir -p $TERMINFO
  '';

  installFlags = [ "PREFIX=$(out)" ];
}

