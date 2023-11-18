{
  outputs,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.vini.imports = [
    outputs.homeManagerModules.hyprland
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = lib.getExe pkgs.hyprland;
        user = "vini";
      };
      default_session = initial_session;
    };
  };
}
