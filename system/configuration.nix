{ config, pkgs, lib, ... }:

{
	imports = [ 
		# Include the results of the hardware scan.	
		./hardware-configuration.nix 
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.zsuper = {
		isNormalUser = true;
		description = "Piyush Kumbhare";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		shell = pkgs.fish;
	};

	virtualisation.docker.enable = true;

	programs.hyprland.enable = true;
	programs.firefox.enable = true;
	programs.fish.enable = true;
	
	# GLOBAL SYSTEM PACKAGES
	environment.systemPackages = with pkgs; [
		# TERMINAL
		kitty

		# TOOLS
		neovim
		wget
		git

		# HARDWARE/TELEMETRY
		swaynotificationcenter
		brightnessctl
		networkmanagerapplet
	];
	
	fonts.fontDir.enable = true;
	
	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	networking.firewall.allowedTCPPorts = [ 22 ];
	networking.firewall.allowedUDPPorts = [ ];
	networking.firewall.enable = true;
	
	# ADVANCED
	nixpkgs.config.allowUnfree = true;
	programs.nix-ld.enable = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];	

	system.stateVersion = "24.11"; # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
}
