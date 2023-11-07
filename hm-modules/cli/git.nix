{
  programs.git = {
    enable = true;
    userName = "Vinicius Oliveira";
    userEmail = "vinicius@myriad.codes";
    ignores = [
      ".envrc"
      ".cache/"
      ".direnv/"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "vinicius507";
    };
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
  programs.lazygit.enable = true;
}
