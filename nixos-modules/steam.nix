{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.entertainment.steam;
in {
  options.entertainment.steam = {
    enable = lib.mkEnableOption "Enable Steam integration";
    enableGamemode = lib.mkEnableOption "Enable GameMode" // {default = true;};
    enableGamescopeSession = lib.mkEnableOption "Enable GameScope session" // {default = true;};
  };
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = cfg.enableGamescopeSession;
    };
    programs.gamemode = {
      enable = cfg.enableGamemode;
      settings.custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
    programs.gamescope.capSysNice = cfg.enableGamescopeSession;
  };
}
