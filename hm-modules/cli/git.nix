{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Vinicius Oliveira";
    userEmail = "viniciusp.olivera@gmail.com";
    ignores = [
      ".cache/"
      ".direnv/"
      ".envrc"
      ".vscode/"
      ".lazy.lua"
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
