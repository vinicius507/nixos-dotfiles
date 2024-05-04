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

  home-manager.sharedModules = [
    outputs.homeManagerModules.vscode
    {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
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

  users.users.vini.hashedPasswordFile = config.sops.secrets."users/vini/password".path;
  users.extraGroups = {
    docker.members = ["vini"];
    libvirtd.members = ["vini"];
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
  };
}
