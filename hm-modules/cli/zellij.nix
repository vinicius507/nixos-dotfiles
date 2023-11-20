{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
    };
  };
  home.packages = with pkgs.zellijUtils; [edit];
}
