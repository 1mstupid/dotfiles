{ ... }:
{
  flake.homeModules.anki =
    { pkgs, ... }:
    let
      ankiAddons = with pkgs.ankiAddons; [
        advanced-browser
        anki-quizlet-importer-extended
        review-heatmap
        reviewer-refocus-card
        passfail2
      ];

      anki = pkgs.anki.withAddons ankiAddons;
    in
    {
      home.packages = [
        anki
      ];
    };
}
