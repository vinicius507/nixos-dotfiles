{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = ["${config.stylix.image}"];
      wallpaper = [
        ",${config.stylix.image}"
      ];
    };
  };
}
