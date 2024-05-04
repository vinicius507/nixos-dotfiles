{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      gcc
      gopls
      lua-language-server
      markdownlint-cli
      marksman
      nil
      shfmt
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
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
