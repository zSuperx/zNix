{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        ripgrep
		htop
		wl-clipboard
        tree
        jq
        playerctl
        socat
        yazi
		wofi
    ];
}
