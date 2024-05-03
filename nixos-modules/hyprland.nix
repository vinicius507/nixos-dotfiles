{
  outputs,
  config,
  pkgs,
  ...
}: {
  home-manager.sharedModules = [
    outputs.homeManagerModules.hyprland
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
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
        ];
      };
    };
  };
}
