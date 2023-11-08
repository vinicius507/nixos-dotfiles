{
  base = {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.05";
  };
  cli = {...}: {
    imports = [
      ./cli/direnv.nix
      ./cli/fish.nix
      ./cli/starship.nix
      ./cli/git.nix
    ];
  };
}
