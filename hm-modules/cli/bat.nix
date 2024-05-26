{pkgs, ...}: {
  programs.bat.enable = true;
  programs.fish.shellAliases = {
    cat = "${pkgs.bat}/bin/bat";
  };
}
