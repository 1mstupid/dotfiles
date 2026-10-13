{
  config,
  pkgs,
  inputs,
  programs,
  ...
}:
{
  home.packages = with pkgs; [
    programs.zsh-wrapper
    programs.ghostty
    programs.qs
    programs.mpv
    programs.helix
    programs.ncmpcpp
    programs.anki

    qbittorrent-enhanced
    yazi
    feh
    ov
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
    inputs.ayugram-desktop.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    inputs.zapfast.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.ranma.packages.${pkgs.stdenv.hostPlatform.system}.default


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
