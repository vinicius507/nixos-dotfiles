{
  programs = {
    git = {
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
      includes = [
        {
          condition = "gitdir:~/Code/soulloop/**";
          path = builtins.toFile "gitconfig-soulloop.inc" ''
            [user]
              name = "Vinicius Oliveira"
              email = "vinicius@soulloop.com"
          '';
        }
      ];
      extraConfig = {
        init.defaultBranch = "main";
        github.user = "vinicius507";
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
