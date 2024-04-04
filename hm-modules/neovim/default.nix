{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      gcc
      lua-language-server
      marksman
      nil
      shfmt
      stylua
      unzip
      vscode-langservers-extracted
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
