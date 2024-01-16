{
  inputs,
  outputs,
  config,
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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    anytype
    discord
    google-chrome
    pcmanfm
    sops
    spotify
    step-cli
    zoom-us
  ];

  home-manager.users.vini = {
    imports = [
      outputs.homeManagerModules.vscode
    ];
    services.mpris-proxy.enable = true;
  };

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  security.pki.certificateFiles = [
    config.sops.secrets."services/step-ca/root-cert".path
  ];

  services.tailscale.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  sops.secrets."users/vini/password".neededForUsers = true;
  sops.secrets."services/step-ca/root-cert" = {};

  users.users.vini.hashedPasswordFile = config.sops.secrets."users/vini/password".path;
  users.extraGroups.docker.members = ["vini"];

  virtualisation.docker.enable = true;
}
