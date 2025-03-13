{ config, pkgs, ... }:

{
	imports = [
		./packages/dev-tools.nix
		./packages/utils.nix
		./packages/apps.nix
	];

	home.username = "zsuper";
	home.homeDirectory = "/home/zsuper";
	home.packages = [
		# TERMINAL CONFIG
		pkgs.fishPlugins.tide # Fish prompt plugin
		(pkgs.nerdfonts.override {
			fonts = [
				"JetBrainsMono"
			];
		})

		# HYPRLAND
		pkgs.hyprpanel
		pkgs.hyprpaper
		pkgs.hypridle
		pkgs.hyprshot
		pkgs.hyprlock
	];

	programs.kitty = {
		enable = true;
		settings = {
			font_family = "JetBrainsMono Nerd Font Mono";
			bold_font = "JetBrainsMono Nerd Font Mono Extra Bold";
			bold_italic_font = "JetBrainsMono Nerd Font Mono Extra Bold Italic";

			shell = "fish";
			background_opacity = "0.9";
			cursor_trail = "1";
			font_size = "15.0";
		};
		themeFile = "Catppuccin-Macchiato";
	};

	programs.fish = {
		enable = true;
		plugins = [
			{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
		];
		shellAliases = {
			l = "ls -lah";

			grep = "grep --color";
			egrep = "egrep --color";

			# Clipboard
			wlc = "wl-copy";
			wlp = "wl-paste";

			# "It's all nvim?"
			nv = "nvim";
			vi = "nvim";
			vim = "nvim";
			# "Always has been..."

			# Git aliases
			gs = "git status";
		};

		# Disable Fish greeting & add ~/bin to path
		shellInit = ''
			set fish_greeting
			set PATH "$HOME/bin:$PATH"
		'';
	};

	programs.zoxide = {
		enable = true;
		enableBashIntegration = true;
		options = [ "--cmd cd" ];
	};

	programs.direnv.enable = true;

	home.file = {
		".config/nvim/init.lua".source = ../nvim/init.lua;
		".config/nvim/lua".source = ../nvim/lua;

		".config/hypr".source = ../hypr;
		".config/hyprpanel".source = ../hyprpanel;

        ".config/wofi".source = ../wofi;
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true; 
	nixpkgs.config.allowUnfree = true; # For Spotify
	home.stateVersion = "24.11"; # Don't change this probably
}
