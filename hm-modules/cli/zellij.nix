{pkgs, ...}: {
  programs.zellij = {
    settings = {
      default_layout = "compact";
    };
  };
  home.packages = [pkgs.zellij-edit];
}
