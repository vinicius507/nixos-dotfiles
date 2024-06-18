{pkgs, ...}: {
  home.packages = [pkgs.neovim-remote];
  programs.fish.functions = {
    nv-ssh = "${pkgs.neovim}/bin/nvim oil-ssh://$argv";
  };
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      gcc
      lua-language-server
      markdownlint-cli
      marksman
      nil
      norminette
      prettierd
      shfmt
      sqlfluff
      stylua
      tailwindcss-language-server
      unzip
      vscode-langservers-extracted
      yaml-language-server
      nodePackages.typescript-language-server
    ];
    vimAlias = true;
    withNodeJs = true;
    withRuby = false;
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
    source = ./config;
    recursive = true;
  };
}
