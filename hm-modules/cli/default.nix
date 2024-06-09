{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./zellij.nix
  ];
  home.packages = with pkgs; [
    fd
    fh
    lazydocker
    memos-cli
    ripgrep
    tldr
    tree
  ];
}
