{ config, pkgs, lib, inputs, git, gh, ... }:
{
	imports = [ ./packages.nix ../programs ];
	home = {
		username = "waltz";
		homeDirectory = "/home/waltz";
		stateVersion = "26.05";
		sessionVariables = {
			NH_FLAKE = "${config.home.homeDirectory}/dotfiles";
		  GIT_CONFIG_GLOBAL = "${config.home.homeDirectory}/.local/state/git/config";
		  EDITOR = "hx";
		  QML2_IMPORT_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/qml";
		  VISUAL = "hx";
		  BROWSER = "helium";
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

	xdg.mimeApps = {
	  enable = true;
		defaultApplications = {
		   
		  # Web
		  "text/html" = "helium.desktop";
		  "x-scheme-handler/http" = "helium.desktop";
		  "x-scheme-handler/https" = "helium.desktop";

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

	home.file.".local/share/wallpapers".source =
	  config.lib.file.mkOutOfStoreSymlink
	    "/home/waltz/dotfiles/assets/wallpaper";

	home.packages = [
		git
		gh
	];
	home.activation.gitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
	  mkdir -p "$HOME/.local/state/git"

	  if [ ! -f "$HOME/.local/state/git/config" ]; then
	    printf '%s\n' \
	      '[user]' \
	      '    name = "Ítalo Barros"' \
	      '    email = "italoHSB@tutamail.com"' \
	      '[init]' \
	      '    defaultBranch = main' \
	      '[core]' \
	      '    editor = hx' \
	      > "$HOME/.local/state/git/config"
	  fi
	'';



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
