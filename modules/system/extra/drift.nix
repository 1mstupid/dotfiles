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
    hash = "sha256-X6OGpebIaqY8KVRWUsOlZjwrBrAkRc80W2ZKPrvCjfk=";
  };

  cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Drift";
    homepage = "https://github.com/socatlolmeow/drift";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
