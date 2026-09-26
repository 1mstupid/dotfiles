{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    anki-bin
    broot
    feh
    helix
    kmonad
    librewolf-bin
    mangowc
    mpv
    qbittorrent-enhanced
    quickshell
    rofi
    satty
    tmux
    yazi

    qt6.qtbase
    qt6.qtdeclarative
    kdePackages.qtmultimedia
    qt6Packages.sddm

    ffmpeg
    imagemagick
    playerctl
    pulseaudio
    cava
    awww
    gpu-screen-recorder
    wf-recorder
    grim
    slurp
    sound-theme-freedesktop

    bluez
    pamixer

    cliphist
    wl-clipboard
    libnotify
    xdg-utils
    xdg-launch
    xdg-user-dirs
    desktop-file-utils
    app2unit
    zenity

    adwaita-fonts
    matugen
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

    inputs.ayugram-desktop.packages.${pkgs.system}.default

    # hypridle
    # busybox
    # bibata-cursors
    # dwm
    # super-productivity
    # mpvpaper
    # alacritty
    # xinit
    # bspwm
    # dunst
    # eww
    # picom
    # xclip
    # haskellPackages.greenclip
    # sxhkd
    # qutebrowser
    # polybar
    # hyprland
    # hyprsunset
  ];
}
