{
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./firefox.nix
      ./git.nix
      ./neovim.nix
      ./vscode.nix
    ]
    ++ builtins.attrValues outputs.homeManagerModules;

  home = {
    username = "vini";
    homeDirectory = "/home/vini";
    packages = with pkgs; [
      beekeeper-studio
      bitwarden-desktop
      nautilus
      neovide
      obs-studio
      obsidian
      pcsx2
      pwvucontrol
      slack
      webcord
    ];
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
    stateVersion = "23.11";
  };

  programs = {
    gpg.enable = true;
    zathura.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };

  sops.defaultSopsFile = ../../secrets/default.yaml;
}
