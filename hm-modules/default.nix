{
  base = {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.05";
  };
  cli = {...}: {
    imports = [
      ./cli/direnv.nix
      ./cli/git.nix
    ];
  };
}
