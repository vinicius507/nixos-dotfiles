{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
    tmp.useTmpfs = true;
  };

  networking.hostName = "desktop";
  services.tailscale.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    discord
    foot
    google-chrome
    pcmanfm
    spotify
    zoom-us
  ];

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;

  home-manager.users.vini = {
    imports = [
      outputs.homeManagerModules.vscode
    ];
    services.mpris-proxy.enable = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode = {
    enable = true;
    settings.custom.start = "''${pkgs.libnotify}/bin/notify-send 'GameMode started'";
    settings.custom.end = "''${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["vini"];
}
