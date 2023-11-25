{pkgs, ...}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode = {
    enable = true;
    settings.custom.start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
    settings.custom.end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
  };
  programs.gamescope.capSysNice = true;
}
