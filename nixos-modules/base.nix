{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
  ];

  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  users.users.vini = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };
  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.homeManagerModules.base
      outputs.homeManagerModules.cli
    ];
    useGlobalPkgs = true;
    useUserPackages = true;
    users.vini = {
      home.sessionVariables = {
        BROWSER = "google-chrome-stable";
        EDITOR = "hx";
      };
      sops.defaultSopsFile = ../secrets/default.yaml;
    };
  };

  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

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
    trusted-users = ["root" "@wheel"];
  };

  nixpkgs.overlays = builtins.attrValues outputs.overlays;

  sops.defaultSopsFile = ../secrets/default.yaml;

  stylix = {
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = builtins.fetchurl {
      url = "https://i.imgur.com/OrCZMPm.jpeg";
      sha256 = "sha256:1dd8s9hdfs0zff2aq2nzvi2c3rh60m8g2618x3sybz81xz7kk36x";
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
