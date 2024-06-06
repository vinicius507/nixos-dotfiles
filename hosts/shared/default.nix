{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs;
    [
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
    ]
    ++ builtins.attrValues outputs.nixosModules;

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp.useTmpfs = true;
  };

  console.keyMap = "br-abnt2";

  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.homeManagerModules.base
      outputs.homeManagerModules.cli
      outputs.homeManagerModules.firefox
      outputs.homeManagerModules.vscode
      outputs.homeManagerModules.zed
    ];
    useGlobalPkgs = true;
    useUserPackages = true;
    users.vini = {
      home.sessionVariables = {
        BROWSER = "firefox";
        EDITOR = "nvim";
      };
      sops.defaultSopsFile = ../../secrets/default.yaml;
    };
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_MESSAGES = "en_US.UTF-8";

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
  };

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
    trusted-users = ["root" "@wheel"];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues outputs.overlays;
  };

  programs.fish.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = builtins.concatStringsSep " " [
            "${pkgs.greetd.tuigreet}/bin/tuigreet"
            "--time"
            "--remember-session"
            "--sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
          ];
        };
      };
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    tailscale.enable = true;
  };

  security.pki.certificates = [
    ''
      Dezano CA
      =========
      -----BEGIN CERTIFICATE-----
      MIIBozCCAUmgAwIBAgIQFU/tuiOsb2F49vWfRRbSTzAKBggqhkjOPQQDAjAwMRIw
      EAYDVQQKEwlEZXphbm8gQ0ExGjAYBgNVBAMTEURlemFubyBDQSBSb290IENBMB4X
      DTI0MDExNjE5NDk0NFoXDTM0MDExMzE5NDk0NFowMDESMBAGA1UEChMJRGV6YW5v
      IENBMRowGAYDVQQDExFEZXphbm8gQ0EgUm9vdCBDQTBZMBMGByqGSM49AgEGCCqG
      SM49AwEHA0IABByStps7Y7U6HuLegnyTQZUtv0IHxMsY0j/5PcGRuL1hcK2sY5/q
      pm4r2N7NS3AbDiibGlnaG73ahh4a2thEqOmjRTBDMA4GA1UdDwEB/wQEAwIBBjAS
      BgNVHRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBTNjSNSMvcz3pzGaT7Io3JrBybj
      qDAKBggqhkjOPQQDAgNIADBFAiBem8NG6ZDnCJOPQ61swQg/u0kvC6FbwX7AueMV
      1tqSBgIhAO33uLkR17AUD+IkzihnVxCxXYd+3LwbY1+1kUjNujuN
      -----END CERTIFICATE-----
    ''
  ];

  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    secrets."users/vini/password".neededForUsers = true;
  };

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

  time.timeZone = "America/Sao_Paulo";

  users.users.vini = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };
}
