{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
  inherit (pkgs.waylandUtils) screenshot;
in {
  imports = [
    ./foot.nix
    ./gtk.nix
    ./mako.nix
    ./rofi.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    wl-clipboard
    xdg-utils
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        mouse_refocus = false;
        sensitivity = 0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = lib.mkForce "rgb(${colors.base03})";
        "col.inactive_border" = lib.mkForce "rgb(${colors.base00})";
      };
      exec-once = [
        "${pkgs.mako}/bin/mako"
        "${lib.getExe pkgs.swaybg} -m fill -i ${config.stylix.image}"
        "${lib.getExe pkgs.waybar}"
      ];
      decoration = {
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          xray = true;
          ignore_opacity = true;
        };
        rounding = 0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinback,0.36, 0, 0.66, -0.56"
          "easeoutback,0.34, 1.56, 0.64, 1"
        ];
        animation = [
          "windowsIn,1,3,easeoutback,slide"
          "windowsOut,1,3,easeinback,slide"
          "windowsMove,1,3,easeoutback"
          "workspaces,1,2,easeoutback,slide"
          "fadeIn,1,3,easeout"
          "fadeOut,1,3,easein"
          "fadeSwitch,1,3,easeout"
          "fadeShadow,1,3,easeout"
          "fadeDim,1,3,easeout"
          "border,1,3,easeout"
        ];
      };
      dwindle = {
        no_gaps_when_only = 1;
        pseudotile = true;
        preserve_split = true;
      };
      master.new_is_master = true;
      gestures.workspace_swipe = false;
      windowrulev2 = [
        "float,class:^(pcmanfm)$"
      ];
      "$mod" = "SUPER";
      bind = [
        "$mod, Space, exec, rofi -show drun"
        "$mod, R, exec, ${lib.getExe pkgs.rofiUtils.run}"
        "$mod, Return, exec, foot"
        "$mod SHIFT, Return, exec, [float] foot"
        "$mod SHIFT, C, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, F, fullscreen,0"
        "$mod, M, fullscreen,1"
        "$mod, V, togglefloating,"
        "$mod, V, centerwindow,"
        "$mod, E, exec, pcmanfm"
        "$mod, P, pin,"
        "$mod, O, togglesplit, # dwindle"
        "$mod SHIFT, P, pseudo, # dwindle"
        "$mod SHIFT, F, fakefullscreen,"
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod SHIFT, H, swapwindow, l"
        "$mod SHIFT, J, swapwindow, d"
        "$mod SHIFT, K, swapwindow, u"
        "$mod SHIFT, L, swapwindow, r"
        "$mod, 1, moveworkspacetomonitor, 1 current"
        "$mod, 1, workspace, 1"
        "$mod, 2, moveworkspacetomonitor, 2 current"
        "$mod, 2, workspace, 2"
        "$mod, 3, moveworkspacetomonitor, 3 current"
        "$mod, 3, workspace, 3"
        "$mod, 4, moveworkspacetomonitor, 4 current"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, S, togglespecialworkspace"
        "$mod SHIFT, S, movetoworkspace, special"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        ", Print, exec, ${lib.getExe screenshot} section"
        "SHIFT, Print, exec, ${lib.getExe screenshot} full"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      bind = $mod SHIFT, R, submap, resize
      submap = resize
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , j, resizeactive, 0 -10
      binde = , k, resizeactive, 0 10
      bind = , escape, submap, reset
      bind = , Return, submap, reset
      submap = reset
    '';
  };
}
