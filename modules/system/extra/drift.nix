{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage {
  pname = "drift";
  version = "unstable-2026-10-17";

  src = fetchFromGitHub {
    owner = "socatlolmeow";
    repo = "drift";
    rev = "main";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Drift";
    homepage = "https://github.com/socatlolmeow/drift";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
