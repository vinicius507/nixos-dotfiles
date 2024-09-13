{pkgs, ...}: {
  programs.btop.enable = true;
  programs.fish.shellAliases = {
    htop = "${pkgs.btop}/bin/btop";
  };
}
