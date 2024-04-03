{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      gcc
      lua-language-server
      nil
      shfmt
      stylua
      unzip
      vscode-langservers-extracted
    ];
    withNodeJs = true;
    withRuby = false;
  };
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
