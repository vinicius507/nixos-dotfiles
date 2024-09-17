{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.cli;
in {
  imports = [
    ./starship.nix
    ./zellij.nix
  ];

  options.dotfiles.cli = {
    enable =
      lib.mkEnableOption "CLI configuration"
      // {
        default = true;
      };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tree
    ];

    programs = {
      bat.enable = true;
      btop.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      eza = {
        enable = true;
        icons = true;
        enableFishIntegration = true;
      };

      fd.enable = true;

      fish = {
        enable = true;
        shellAliases = {
          cat = "${pkgs.bat}/bin/bat";
          htop = "${pkgs.btop}/bin/btop";
          gitignore = "${pkgs.curl}/bin/curl -sL https://gitignore.io/api/$argv";
          lg = "${pkgs.lazygit}/bin/lazygit";
        };
        interactiveShellInit = ''
          set -g fish_greeting
          set acceptable_terms xterm-256color screen256-color xterm-termite

          if contains $TERM $acceptable_terms
              fish_vi_key_bindings
          end
        '';
      };

      lazygit.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      zellij.enable = true;
    };
  };
}
