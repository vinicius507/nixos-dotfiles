{
  base = {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.11";

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
  };
  cli = {pkgs, ...}: {
    imports = [
      ./cli/bat.nix
      ./cli/direnv.nix
      ./cli/eza.nix
      ./cli/fish.nix
      ./cli/git.nix
      ./cli/helix.nix
      ./cli/starship.nix
      ./cli/zellij.nix
    ];
    home.packages = with pkgs; [
      fd
      fh
      ripgrep
      tldr
      tree
    ];
  };
  hyprland = import ./hyprland;
  vscode = import ./vscode;
}
