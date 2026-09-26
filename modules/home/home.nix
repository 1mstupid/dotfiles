{ config, pkgs, inputs, ... }:
{
	imports = [ ./packages.nix ./programs ];
	home = {
		username = "waltz";
		homeDirectory = "/home/waltz";
		stateVersion = "26.05";
		sessionVariables = {
		  EDITOR = "hx";
		  QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
		  VISUAL = "hx";
		  BROWSER = "librewolf";
		};
		pointerCursor = {
			enable = true;
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
		  "text/html" = "librewolf.desktop";
		  "x-scheme-handler/http" = "librewolf.desktop";
		  "x-scheme-handler/https" = "librewolf.desktop";

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
		  "image/svg+xml" = "librewolf.desktop";

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

	xdg.configFile = {
	  "kmonad".source = ./config/kmonad;
	  "wallpaper".source =
	  	config.lib.file.mkOutOfStoreSymlink
		  	"/home/waltz/dotfiles/assets/wallpaper";
	  "rofi".source =
	  	config.lib.file.mkOutOfStoreSymlink
	  		"/home/waltz/dotfiles/modules/home/config/rofi";
	  "zsh".source = ./config/zsh;
	  "helix".source = ./config/helix;
	  "mpv".source = ./config/mpv;
	  "mango".source =
	    config.lib.file.mkOutOfStoreSymlink
	      "/home/waltz/dotfiles/modules/home/config/mango";
	};

	programs.gh.enable = true;

  dconf = {
  	enable = false;
  	settings = {
	    "org/gnome/desktop/interface" = {
	      color-scheme = "prefer-dark";
	      gtk-theme = "Adwaita-dark";
	    };
	  };
	};
}
