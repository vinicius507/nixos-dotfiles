{config, ...}: let
  colors = config.lib.stylix.colors;
  rgb = color: let
    red = colors."${color}-rgb-r";
    green = colors."${color}-rgb-g";
    blue = colors."${color}-rgb-b";
  in "rgb(${red}, ${green}, ${blue})";
  rgba = color: alpha: let
    red = colors."${color}-rgb-r";
    green = colors."${color}-rgb-g";
    blue = colors."${color}-rgb-b";
  in "rgba(${red}, ${green}, ${blue}, ${alpha})";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
        disable_loading_bar = true;
      };
      background = [
        {
          path = builtins.toString config.stylix.image;
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      image = {
        path = "${./face.jpg}";
        size = 128;
        border_size = 0;
        position = "0, 32";
        halign = "center";
        valign = "center";
        shadow_passes = 1;
      };
      input-field = [
        {
          size = "180, 42";
          position = "0, -72";
          dots_center = true;
          fade_on_empty = false;
          font_color = rgb "base05";
          inner_color = rgba "base05" "0.3";
          fail_color = rgb "base08";
          outline_thickness = 0;
          placeholder_text = "Password";
          shadow_passes = 1;
        }
      ];
    };
  };
  stylix.targets.hyprlock.enable = false;
}
