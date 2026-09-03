{ config, pkgs, inputs, ... }:
let
	st = pkgs.callPackage ./pkgs/st-flexi/default.nix { };
in
{
	home = {
		username = "waltz";
		homeDirectory = "/home/waltz";
		stateVersion = "26.05";
		sessionVariables = {
		  EDITOR = "hx";
		  QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
		  VISUAL = "hx";
		  BROWSER = "helium-browser";
		};
		pointerCursor = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
		};
	};
	home.sessionPath = [
	  "${config.home.homeDirectory}/.cargo/bin"
	  "${config.home.homeDirectory}/.local/bin"
	];
	
	programs.home-manager.enable = true;
	programs.bash = {
		enable = true;
	};

	programs.git = {
		enable = true;
		settings.user = {
			name = "Ítalo Barros";
			email = "italolv20@gmail.com";
		};
	};	


	xdg.mimeApps = {
	  enable = true;
		defaultApplications = {
		   
		  # Web
		  "text/html" = "helium-browser.desktop";
		  "x-scheme-handler/http" = "helium-browser.desktop";
		  "x-scheme-handler/https" = "helium-browser.desktop";

		  # Torrents
		  "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
		  "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";

		  # Text / code
		  "text/plain" = "Helix.desktop";
		  "text/markdown" = "Helix.desktop";
		  "text/x-c" = "Helix.desktop";
		  "text/x-c++" = "Helix.desktop";
		  "text/x-python" = "Helix.desktop";
		  "text/x-rust" = "Helix.desktop";
		  "text/x-shellscript" = "Helix.desktop";

		  # Documents
		  "application/pdf" = "sioyek.desktop";

		  # Images
		  "image/jpeg" = "imv.desktop";
		  "image/png" = "imv.desktop";
		  "image/gif" = "imv.desktop";
		  "image/webp" = "imv.desktop";
		  "image/svg+xml" = "helium-browser.desktop";

		  # Video
		  "video/mp4" = "mpv.desktop";
		  "video/webm" = "mpv.desktop";
		  "video/x-matroska" = "mpv.desktop";
		  "video/quicktime" = "mpv.desktop";

		  # Audio
		  "audio/mpeg" = "mpv.desktop";
		  "audio/ogg" = "mpv.desktop";
		  "audio/flac" = "mpv.desktop";
		  "audio/wav" = "mpv.desktop";
		};
	};

	programs.zsh = {
	  enable = true;
	  autocd = true;
	  shellAliases = {
	  	config = "hx ~/dotfiles/configuration.nix";
		  ns = "nix search nixpkgs";
	  	hm = "hx ~/dotfiles/home.nix";
	  	flake = "hx ~/dotfiles/flake.nix";
	    update = "git -C ~/dotfiles add . && git -C ~/dotfiles commit -m 'minor' && sudo nixos-rebuild switch --flake ~/dotfiles#nixos-btw";
	  };
	  oh-my-zsh = {
	    enable = true;
	    plugins = [
	      "git"
	    ];
	  };

	  plugins = [
	    {
	      name = "fast-syntax-highlighting";
	      src = pkgs.zsh-fast-syntax-highlighting;
	    }
	    {
	      name = "zsh-vi-mode";
	      src = pkgs.zsh-vi-mode;
	    }
	  ];
	};

	home.file = {
		# ".config/eww".source = ./config/eww;
		# ".config/rofi".source = ./config/rofi;
		# ".config/dunst".source = ./config/dunst;
		# ".config/bspwm".source = ./config/bspwm;
		# ".config/mango".source = ./config/mango;
		# ".config/polybar".source = ./config/polybar;
		# ".config/sxhkd".source = ./config/sxhkd;
		".config/kmonad".source = ./config/kmonad;
		".config/zsh".source = ./config/zsh;
		".config/helix".source = ./config/helix;
	  ".config/mpv".source = ./config/mpv;
	  # ".config/hypr".source = ./config/hypr;
	  # ".config/nvim".source = ./config/nvim;	
		# ".config/picom".source = ./config/picom;
	};
	xdg.configFile = {
		# "mango" = {
		# source = config.lib.file.mkOutOfStoreSymlink "/home/waltz/dotfiles/config/mango";
		# recursive = true;
		# };
		"hypr" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/waltz/dotfiles/config/hypr";
			recursive = true;
			};
		};

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

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
		imagemagick
		ffmpeg
		adwaita-fonts 
		satty
		swaybg
		brightnessctl
		cava
		cliphist
		wl-clipboard
		libpulseaudio
		xdg-utils
		slurp
		xdg-launch
		gpu-screen-recorder
		wf-recorder
		fd
		libpulseaudio
		bluez
		xdg-user-dirs
		matugen
		ddcutil
		zenity
		hypridle
		kmonad
	  pamixer
		libnotify
		python3
		dbus
		readest
		neovim
		helix
		mpv
		# busybox
		feh
		tmux
		ripgrep
		# nil
		# nixpkgs-fmt
		nodejs
		yazi
		gcc
	  # bibata-cursors
		anki-bin
		app2unit
		st
		grim
		desktop-file-utils		
		qt6Packages.sddm
	  inputs.helium.packages.${pkgs.system}.default
		xdg-user-dirs
		# mpvpaper 
		# alacritty
		# xinit
		# rofi
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
		# mangowc
		# hyprland
		# hyprsunset
		# librewolf-bin
	];
}
