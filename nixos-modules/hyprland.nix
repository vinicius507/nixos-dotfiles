{
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
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    security.pam.services.hyprlock = {};
  };
}
