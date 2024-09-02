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

  desktop.hyprland.enable = true;

  entertainment.steam.enable = true;

  networking.hostName = "desktop";

  environment.systemPackages = with pkgs; [
    discord
    google-chrome
    obsidian
    pcsx2
    nautilus
    sops
    spotify
    step-cli
    virtiofsd
    webcord
    wireshark
  ];

  home-manager.sharedModules = [
    {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
      programs.git.signing = {
        signByDefault = true;
        key = "AD3ED787366ACED9";
      };
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

  users = {
    users.vini.hashedPasswordFile = config.sops.secrets."users/vini/password".path;
    extraGroups = {
      docker.members = ["vini"];
      libvirtd.members = ["vini"];
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
  };

  system.stateVersion = "23.11";
}
