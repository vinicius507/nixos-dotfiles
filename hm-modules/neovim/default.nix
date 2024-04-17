{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      gcc
      lua-language-server
      markdownlint-cli
      marksman
      nil
      shfmt
      stylua
      unzip
      vscode-langservers-extracted
      yaml-language-server
    ];
    vimAlias = true;
    withNodeJs = true;
    withRuby = false;
  };
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
