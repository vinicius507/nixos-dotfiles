{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  users.users.vini = {
    isNormalUser = true;
    initialPassword = "changeme";
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.vini = {
    imports = [
      outputs.homeManagerModules.base
      outputs.homeManagerModules.cli
      outputs.homeManagerModules.nvchad
    ];
    programs.nvchad = {
      enable = true;
      settings = {
        ui.theme = "catppuccin";
        ui.transparency = true;
      };
    };
  };

  programs.fish.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = "vini";

  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_MESSAGES = "en_US.UTF-8";

  time.timeZone = "America/Sao_Paulo";

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 2d";

  # Add each flake input as a registry
  # To make nix3 commands consistent with the flakes
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    extra-substituters = ["https://vinicius507.cachix.org/"];
    extra-trusted-public-keys = [
      "vinicius507.cachix.org-1:cWsivfWENRKZ19obQM96XtSKha88BEuQWQt+qEFFnYE="
    ];
  };

  system.stateVersion = "23.05";
}
