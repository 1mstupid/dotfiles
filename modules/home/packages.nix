{config, pkgs, inputs, ... }:
let
  st = pkgs.callPackage ../system/packages/st-flexi/default.nix {};
in
{
  	home.packages = with pkgs; [
		(symlinkJoin {
	    name = "sioyek";
	    paths = [ sioyek ];

	    nativeBuildInputs = [ makeWrapper ];

	    postBuild = ''
	      wrapProgram $out/bin/sioyek \
	        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pipewire ]}
	    '';
	  })
		quickshell
		qt6.qtbase
		qt6.qtdeclarative
  	kdePackages.qtmultimedia
		qbittorrent-enhanced
		jq
		yazi
		imagemagick
		ffmpeg
		awww
		adwaita-fonts 
		satty
		brightnessctl
		cava
		cliphist
		wl-clipboard
		xdg-utils
	  sound-theme-freedesktop
		slurp
		xdg-launch
		gpu-screen-recorder
		wf-recorder
		fd
		pulseaudio
		bluez
		xdg-user-dirs
		matugen
		ddcutil
		zenity
		# hypridle
		kmonad
	  pamixer
		libnotify
		python3
		dbus
		helix
		mpv
		# busybox
		feh
		tmux
		ripgrep
		# nil
		# nixpkgs-fmt
		nodejs
		# super-productivity
		gcc
	  # bibata-cursors
		anki-bin
		app2unit
		# dwm
		st
		grim
		broot
		desktop-file-utils		
		xdg-user-dirs
		qt6Packages.sddm
    inputs.ayugram-desktop.packages.${pkgs.system}.default
		# mpvpaper 
		# alacritty
		# xinit
		rofi
		# bspwm
		#	dunst
		# vxwm
		# eww
		# picom
    # xclip
		# haskellPackages.greenclip
		# sxhkd
		# qutebrowser
		# polybar
		mangowc
		# hyprland
		# hyprsunset
		librewolf-bin
	];
}
