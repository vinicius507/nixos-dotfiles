{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "${config.stylix.fonts.monospace.name} 12";
    terminal = lib.getExe pkgs.foot;
    theme = {
      "*" = {
        accent = mkLiteral "#${colors.base0D}";
        background = mkLiteral "#${colors.base00}";
        background-alt = mkLiteral "#${colors.base02}";
        border-color = mkLiteral "#${colors.base02}";
        foreground = mkLiteral "#${colors.base05}";
        selected = mkLiteral "#${colors.base02}";
        active = mkLiteral "#${colors.base02}";
        urgent = mkLiteral "#${colors.base08}";
      };
      window = {
        anchor = "north";
        location = "center";
        transparency = "real";
        fullscreen = false;
        width = mkLiteral "25%";
        border = mkLiteral "2px";
        border-color = mkLiteral "@border-color";
        border-radius = mkLiteral "3px";
        background-color = mkLiteral "@background";
      };
      mainbox = {
        enabled = true;
        spacing = 0;
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [
          "inputbar"
          "listbox"
        ];
      };
      inputbar = {
        enabled = true;
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        orientation = mkLiteral "horizontal";
        children = map mkLiteral ["textbox-prompt-drun" "entry"];
      };
      textbox-prompt-drun = {
        enabled = true;
        expand = false;
        str = "";
        padding = mkLiteral "12px 8px 12px 15px";
        text-color = mkLiteral "@accent";
        background-color = mkLiteral "transparent";
      };
      textbox-prompt-run = {
        enabled = true;
        expand = false;
        str = "";
        padding = mkLiteral "12px 0px 12px 15px";
        text-color = mkLiteral "@accent";
        background-color = mkLiteral "transparent";
      };
      entry = {
        enabled = true;
        expand = true;
        cursor = mkLiteral "text";
        padding = mkLiteral "12px 16px";
        text-color = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        placeholder-color = mkLiteral "inherit";
      };
      listbox = {
        spacing = mkLiteral "15px";
        padding = mkLiteral "15px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral ["message" "listview"];
      };
      dummy = {
        expand = true;
        background-color = mkLiteral "transparent";
      };
      mode-switcher = {
        enabled = true;
        padding = mkLiteral "15px";
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };
      button = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      listview = {
        enabled = true;
        lines = 6;
        columns = 1;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = false;
        fixed-columns = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };
      element = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "8px";
        border-radius = mkLiteral "3px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@foreground";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      element-icon = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "24px";
        cursor = mkLiteral "inherit";
      };
      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      message = {
        background-color = mkLiteral "transparent";
      };
      textbox = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      error-message = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
    extraConfig = {
      modes = map mkLiteral ["drun" "run"];
      show-icons = true;
      icon-theme = config.gtk.iconTheme.name;
      match = "fuzzy";
    };
  };
  stylix.targets.rofi.enable = false;
}
