{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
    spotify
    vscode
    prismlauncher
    obsidian
  ];
}
