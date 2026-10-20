{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.git = moduleWithSystem (
    {self'}: {
      programs.git = {
        enable = true;
        package = self'.packages.git;
      };
    }
  );

  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        git-secret
      ];

      settings = {
        user = {
          name = "Ítalo Barros";
          email = "italoHSB@tutamail.com";
        };

        credential.helper = "store";
      };
    };
  };
}
