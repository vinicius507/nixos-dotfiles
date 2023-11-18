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
  hyprland = {pkgs, ...}: {
    imports = [
      ./hyprland/config.nix
      ./hyprland/gtk.nix
    ];
    home.packages = with pkgs; [
      pcmanfm
    ];
    programs.wezterm.enable = true;
    wayland.windowManager.hyprland.enable = true;
  };
  nvchad = import ./nvchad;
}
