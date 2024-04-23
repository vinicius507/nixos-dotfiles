{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
    };
  };
  home.packages = [pkgs.zellij-edit];
}
