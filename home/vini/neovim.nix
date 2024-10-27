{pkgs, ...}: {
  home.packages = [pkgs.neovim-remote];
  programs = {
    fish.functions.ssh-edit = "${pkgs.neovim}/bin/nvim oil-ssh://$argv";
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        alejandra
        fzf
        gcc
        gnumake
        go
        unzip
      ];
      vimAlias = true;
      withNodeJs = true;
      withRuby = false;
    };
  };
  stylix.targets.neovim.enable = false;
}
