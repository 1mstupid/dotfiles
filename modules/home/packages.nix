{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  p = inputs.self.packages.${system};
  drift = pkgs.callPackage ../system/extra/drift.nix {};
in
{
  home.packages = with pkgs; [
    p.qs
    p.zsh
    p.mpv
    p.helix
    p.ncmpcpp
    p.anki

    qbittorrent-enhanced
    tuios
    yazi
    feh
    librewolf-bin
    ov
    herdr
    xplr
    seahorse
    tuios
    cinny
    vis

    adwaita-icon-theme

    ffmpeg
    imagemagick
    playerctl
    pulseaudio
    awww
    wf-recorder
    grim
    slurp
    sound-theme-freedesktop

    bluez
    pamixer

    wl-clipboard
    wlsunset
    libnotify
    xdg-utils
    xdg-launch
    xdg-user-dirs
    desktop-file-utils
    zenity

    adwaita-fonts
    ddcutil

    fd
    fzf
    jq
    ripgrep
    binutils
    python3
    nodejs

    yt-dlp

    nvd
    nix-output-monitor
    inputs.ayugram-desktop.packages.${system}.default
    inputs.zapfast.packages.${system}.default
    drift



    (symlinkJoin {
      name = "sioyek";
      paths = [ sioyek ];

      nativeBuildInputs = [ makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/sioyek \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pipewire ]}
      '';
    })
  ];
}
