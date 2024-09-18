{
  inputs,
  config,
  pkgs,
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

  environment.systemPackages = with pkgs; [
    google-chrome
    nautilus
    obsidian
    virtiofsd
    webcord
    wireshark
  ];

  networking.hostName = "minipc";
  networking.networkmanager.wifi.powersave = false;

  home-manager.sharedModules = [
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

  programs.virt-manager.enable = true;

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

  users = {
    users.vini.hashedPasswordFile = config.sops.secrets."users/vini/password".path;
    extraGroups = {
      docker.members = ["vini"];
      libvirtd.members = ["vini"];
    };
  };

  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
  };

  system.stateVersion = "23.11";
}
