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

  entertainment.steam.enable = true;

  networking.hostName = "desktop";

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

  home-manager.sharedModules = [
    outputs.homeManagerModules.vscode
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

  security.rtkit.enable = true;

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

  sops.secrets."users/vini/password".neededForUsers = true;

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
