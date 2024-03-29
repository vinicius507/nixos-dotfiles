{
  programs.git = {
    enable = true;
    userName = "Vinicius Oliveira";
    userEmail = "vinicius@myriad.codes";
    ignores = [
      ".cache/"
      ".direnv/"
      ".envrc"
      ".vscode/"
    ];
    signing = {
      signByDefault = true;
      key = "AD3ED787366ACED9";
    };
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
