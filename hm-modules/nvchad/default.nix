{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.nvchad;
  chadRcOptions = types.attrs; # TODO: modularize chadRc
in {
  options.programs.nvchad = {
    enable = mkEnableOption "NvChad";
    package = mkOption {
      type = types.package;
      default = pkgs.nvchad;
      description = "Package for NvChad basic configuration.";
    };
    nvimPackage = mkOption {
      type = types.package;
      default = pkgs.neovim;
      description = "Neovim Package to use";
    };
    finalPackage = mkOption {
      type = types.package;
      readOnly = true;
      description = "Resulting NvChad configuration.";
    };
    finalNvimPackage = mkOption {
      type = types.package;
      readOnly = true;
      description = "Resulting NvChad configuration.";
    };
    settings = mkOption {
      type = chadRcOptions;
      description = "User configuration for NvChad.";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.nvimPackage];
    xdg.configFile."nvim" = {
      source = cfg.finalPackage;
    };
    programs.nvchad.finalPackage = pkgs.symlinkJoin {
      name = "nvchad";
      paths = [
        cfg.package
        (pkgs.writeTextDir "lua/custom/chadrc.lua" ''
          -- Generated by Home Manager.
          return ${lib.generators.toLua {} cfg.settings}
        '')
        (pkgs.writeTextDir "lua/custom/init.lua" ''
          -- Generated by Home Manager.
        '')
      ];
    };
    programs.nvchad.finalNvimPackage = cfg.nvimPackage;
  };
}