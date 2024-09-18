{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./git.nix
  ];
  home = {
    username = "vini";
    homeDirectory = "/home/vini";
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
    stateVersion = "23.11";
  };
  programs.gpg.enable = true;
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  sops.defaultSopsFile = ../../secrets/default.yaml;
}
