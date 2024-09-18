{pkgs, ...}: {
  home.packages = [pkgs.neovim-remote];
  programs = {
    fish.functions.ssh-edit = "${pkgs.neovim}/bin/nvim oil-ssh://$argv";
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        alejandra
        black
        dockerfile-language-server-nodejs
        gcc
        lua-language-server
        markdownlint-cli2
        marksman
        nil
        nodePackages.prettier
        nodePackages.typescript-language-server
        norminette
        prettierd
        pyright
        ruff
        shfmt
        sqlfluff
        stylua
        tailwindcss-language-server
        taplo
        unzip
        vscode-langservers-extracted
        yaml-language-server
      ];
      vimAlias = true;
      withNodeJs = true;
      withRuby = false;
    };
  };
  systemd.user.services.neovim-server = {
    Unit = {
      Description = "Neovim server";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.neovim}/bin/nvim --headless --listen 127.0.0.1:1010";
      Restart = "always";
      RestartSec = "3";
    };
  };
  xdg.configFile."nvim" = {
    source = "${pkgs.neovim-config}";
    recursive = true;
  };
}
