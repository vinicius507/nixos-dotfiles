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
  cli = {pkgs, ...}: {
    imports = [
      ./cli/bat.nix
      ./cli/direnv.nix
      ./cli/eza.nix
      ./cli/fish.nix
      ./cli/git.nix
      ./cli/helix.nix
      ./cli/starship.nix
      ./cli/zellij.nix
      ./neovim
    ];
    home.packages = with pkgs; [
      fd
      fh
      memos-cli
      ripgrep
      tldr
      tree
    ];
  };
  firefox = import ./firefox;
  hyprland = import ./hyprland;
  vscode = import ./vscode;
  zed = {pkgs, ...}: let
    zed-fhs = pkgs.buildFHSUserEnv {
      name = "zed";
      targetPkgs = pkgs:
        with pkgs; [
          zed-editor
        ];
      runScript = "zed";
    };
  in {
    home.packages = [zed-fhs];
  };
}
