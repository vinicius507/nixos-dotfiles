{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Vinicius Oliveira";
    userEmail = "viniciusp.olivera@gmail.com";
    ignores = [
      ".cache/"
      ".direnv/"
      ".devenv/"
      ".envrc"
      ".vscode/"
      ".lazy.lua"
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
