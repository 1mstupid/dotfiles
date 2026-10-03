{ config, pkgs, lib, inputs, git, gh, xdg, ... }:
{
	imports = [ ./packages.nix ../programs ];
	home = {
		username = "waltz";
		homeDirectory = "/home/waltz";
		stateVersion = "26.05";
		sessionVariables = {
			NH_FLAKE = "${config.home.homeDirectory}/dotfiles";
			XDG_CONFIG_HOME = "${config.home.homeDirectory}/.local/xdg/config";
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

		home.file = {
		  ".local/xdg/config/mimeapps.list".source =
		    xdg.mimeapps;

		  ".local/xdg/config/user-dirs.dirs".source =
		    xdg.userDirs;

		  ".local/xdg/config/user-dirs.locale".source =
		    xdg.userDirsLocale;
	    ".local/share/wallpapers".source =
			  config.lib.file.mkOutOfStoreSymlink
		    "/home/waltz/dotfiles/assets/wallpaper";
		};

	home.packages = [
		git
		gh
	];

	home.activation.gitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
	  mkdir -p "$HOME/.local/state/git"

	  printf '%s\n' \
	    '[user]' \
	    '    name = "Ítalo Barros"' \
	    '    email = "italoHSB@tutamail.com"' \
	    '[init]' \
	    '    defaultBranch = main' \
	    '[core]' \
	    '    editor = hx' \
	    '[credential "https://github.com"]' \
	    '    helper =' \
	    '    helper = !gh auth git-credential' \
	    '[credential "https://gist.github.com"]' \
	    '    helper =' \
	    '    helper = !gh auth git-credential' \
	    > "$HOME/.local/state/git/config"
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
