{ stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "samaritan-sddm-theme";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "omerwk";
    repo = "samaritan-sddm-theme";
    rev = "main";
    hash = "sha256-yyoF0UzLR8gAizXQmtNZZfMshbduTg86PrSyoo/n0WI=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/samaritan
    cp -r ./* $out/share/sddm/themes/samaritan/
  '';
}
