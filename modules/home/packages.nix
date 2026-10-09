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
    programs.mango
    programs.qs
    programs.mpv
    programs.alacritty
    programs.helix
    programs.tmux
    programs.ncmpcpp
    programs.anki

    yazi
    feh
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
    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop

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
