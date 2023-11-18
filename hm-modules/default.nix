{
  base = {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.11";
  };
  cli = {pkgs, ...}: {
    imports = [
      ./cli/bat.nix
      ./cli/direnv.nix
      ./cli/eza.nix
      ./cli/fish.nix
      ./cli/starship.nix
      ./cli/git.nix
      ./cli/zellij.nix
    ];
    home.packages = with pkgs; [
      fd
      ripgrep
      tldr
      tree
    ];
  };
  hyprland = import ./hyprland;
  nvchad = import ./nvchad;
  vscode = import ./vscode;
}
