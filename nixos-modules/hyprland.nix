{
  outputs,
  config,
  lib,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland compositor";
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      outputs.homeManagerModules.hyprland
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
