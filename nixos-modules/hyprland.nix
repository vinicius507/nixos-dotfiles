{
  outputs,
  config,
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
    settings = {
      default_session = {
        user = "greeter";
        command = builtins.concatStringsSep " " [
          "${pkgs.greetd.tuigreet}/bin/tuigreet"
          "--time"
          "--remember-session"
          "--sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions"
          "--cmd Hyprland"
        ];
      };
    };
  };
}
