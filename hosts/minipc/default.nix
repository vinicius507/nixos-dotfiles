{
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  desktop.hyprland.enable = true;

  entertainment.steam.enable = true;

  networking.hostName = "minipc";
  networking.networkmanager.wifi.powersave = false;

  home-manager.sharedModules = [
    outputs.homeManagerModules.vscode
    {
      services.mpris-proxy.enable = true;
    }
  ];

  hardware.bluetooth = {
    enable = true;
    settings = {
      General.Experimental = true;
    };
  };

  security.rtkit.enable = true;

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

  users.users.vini.hashedPasswordFile = config.sops.secrets."users/vini/password".path;

  users.extraGroups.docker.members = ["vini"];

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}
