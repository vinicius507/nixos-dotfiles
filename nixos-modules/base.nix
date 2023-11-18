{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
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
    home.sessionVariables = {
      BROWSER = "google-chrome-stable";
      EDITOR = "nvim";
    };
    programs.nvchad = {
      enable = true;
      settings = {
        ui.theme = "catppuccin";
        ui.transparency = true;
      };
    };
  };

  programs.fish.enable = true;

  console.keyMap = "br-abnt2";

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

  nixpkgs.overlays = builtins.attrValues outputs.overlays;

  stylix = {
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = builtins.fetchurl {
      url = "https://cdn.discordapp.com/attachments/635625973764849684/1113554221653037127/1_pexels-elijah-odonnell-4173624.jpg";
      sha256 = "0dhd16r6npar8rb7y3xddb7prs5c1mi8ssplkngsaqrmyip683gm";
    };
    opacity = {
      desktop = 0.6;
      popups = 0.8;
      terminal = 0.8;
    };
    cursor = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    fonts = {
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twitter-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };
      sansSerif = {
        name = "Roboto";
        package = pkgs.roboto;
      };
      serif = {
        name = "Roboto Slab";
        package = pkgs.roboto-slab;
      };
    };
  };

  system.stateVersion = "23.11";
}
