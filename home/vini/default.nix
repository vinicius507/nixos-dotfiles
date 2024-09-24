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
      bitwarden-desktop
      neovide
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
