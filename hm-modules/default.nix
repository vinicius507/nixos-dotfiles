{
  base = {pkgs, ...}: {
    home.username = "vini";
    home.homeDirectory = "/home/vini";
    home.stateVersion = "23.11";

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
    systemd.user.tmpfiles.rules = [
      "d %t/downloads 0700 - - - -"
      "L %h/Downloads - - - - %t/downloads"
    ];
  };
  cli = import ./cli;
  firefox = import ./firefox;
  hyprland = import ./hyprland;
  neovim = import ./neovim;
  vscode = import ./vscode;
}
