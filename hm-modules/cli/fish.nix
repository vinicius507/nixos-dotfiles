{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      set acceptable_terms xterm-256color screen256-color xterm-termite

      if contains $TERM $acceptable_terms
          fish_vi_key_bindings
      end
    '';
    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };
    functions = {
      gitignore = "${pkgs.curl}/bin/curl -sL https://gitignore.io/api/$argv";
      nv-ssh = "${pkgs.neovim}/bin/nvim oil-ssh://$argv";
    };
  };
}
