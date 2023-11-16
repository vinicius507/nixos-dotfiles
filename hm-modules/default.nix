{
  base = {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.05";
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
  nvchad = import ./nvchad;
}
