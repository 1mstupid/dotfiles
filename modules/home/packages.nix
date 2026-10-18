
{ ... }:
{
  flake.homeModules.packages =
    { inputs, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      home.packages = with pkgs; [
        qbittorrent-enhanced
        yazi
        feh
        librewolf-bin
        ov
        herdr
        xplr
        seahorse
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

        inputs.qs.packages.${system}.default
        inputs.mpv.packages.${system}.default
        inputs.ayugram-desktop.packages.${system}.default
        inputs.zapfast.packages.${system}.default

        drift

        (symlinkJoin {
          name = "sioyek";
          paths = [ sioyek ];

          nativeBuildInputs = [ makeWrapper ];

          postBuild = ''
            wrapProgram $out/bin/sioyek \
              --prefix LD_LIBRARY_PATH : ${
                lib.makeLibraryPath [ pipewire ]
              }
          '';
        })
      ];
    };
}
