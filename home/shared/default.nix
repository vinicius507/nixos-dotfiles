{pkgs, ...}: {
  home.packages = with pkgs; [
    lazydocker
    tldr
  ];
  systemd.user.tmpfiles.rules = [
    "d %t/downloads 0700 - - - -"
    "L %h/Downloads - - - - %t/downloads"
  ];
}
