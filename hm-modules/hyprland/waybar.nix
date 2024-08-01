{config, ...}: let
  inherit (config.stylix) fonts;
  inherit (config.lib.stylix) colors;

  hex = color: "#${color}";
  markup = text: color: "<span color='${color}'>${text}</span>";
in {
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "bottom";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "hyprland/submap"
          "network"
          "pulseaudio"
          "clock"
        ];
        "hyprland/workspaces" = {
          format = "{icon} {windows}";
          format-window-separator = " ";
          window-rewrite-default = "󰣆";
          window-rewrite = {
            "class<code>" = "󰨞";
            "class<firefox> title<*.github.*>" = "";
            "class<firefox>" = "";
            "class<foot> title<nvim.*>" = "";
            "class<neovide>" = "";
            "class<pcsx2-qt>" = "";
            "class<wireshark>" = "󱢺";
            "discord" = "";
            "foot" = "";
            "steam" = "";
            "title<.*youtube.*>" = "";
          };
          tooltip = true;
          persistent-workspaces = {
            "*" = 4;
          };
        };
        "hyprland/window" = {
          rewrite = {
            "Zellij \((.*)\).*" = "Zellij - ($1)";
          };
        };
        "hyprland/submap" = {
          format = "${markup "mode" (hex colors.base0C)} {}";
        };
        network = rec {
          interface = "enp6s0";
          format = "${markup "web" (hex colors.base0B)} connected";
          tooltip-format = "${format} via {ifname}";
        };
        pulseaudio = {
          format = "${markup "sound" (hex colors.base09)} {volume}%";
          format-bluetooth = "${markup "sound" (hex colors.base0D)} {volume}%";
          format-muted = "${markup "sound" (hex colors.base09)} muted";
          scroll-step = 1;
          ignored-sinks = ["Family 17h/19h HD Audio Controller Digital Stereo (IEC958)"];
        };
        clock = {
          format = "${markup "time" (hex colors.base0D)} {:%H:%M}";
          format-alt = "${markup "date" (hex colors.base0D)} {:%d/%m/%Y}";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: ${fonts.sansSerif.name};
        font-size: 12px;
        font-weight: bold;
      }

      window#waybar {
        background: transparent;
        color: ${hex colors.base05};
      }

      #workspaces button {
        color: ${hex colors.base05};
      }

      #workspaces button.empty {
        color: ${hex colors.base03};
      }

      #workspaces button.active {
        color: ${hex colors.base0B};
      }

      #pulseaudio.muted {
        color: ${hex colors.base03};
      }

      #submap,
      #network,
      #pulseaudio,
      #clock {
        margin-right: 8px;
      }
    '';
  };
  stylix.targets.waybar.enable = false;
}
