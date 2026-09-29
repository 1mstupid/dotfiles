{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    broot
    feh
    helix
    kmonad
    mpv
    tmux

    adwaita-icon-theme
    quickshell
    qt6.qtbase
    qt6.qtdeclarative
    kdePackages.qtmultimedia
    qt6Packages.sddm

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
    brightnessctl
    ddcutil

    fd
    fzf
    jq
    ripgrep
    python3
    nodejs
    gcc
    dbus

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

    inputs.ayugram-desktop.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
