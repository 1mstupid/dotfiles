{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    broot
    yazi
    feh
    vis
    helix
    kmonad
    inputs.mpv.packages.${pkgs.stdenv.hostPlatform.system}.default
    tmux

    adwaita-icon-theme

    ffmpeg
    imagemagick
    playerctl
    pulseaudio
    awww
    wf-recorder
    grim
    slurp
    qbittorrent
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
    python3
    nodejs

    yt-dlp

    nvd
    nix-output-monitor
    # nil
    # nixpkgs-fmt

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
