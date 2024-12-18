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

    ./hyprland.nix
    ./services/syncthing.nix
    ./steam.nix
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

  networking.hostName = "desktop";

  environment.systemPackages = with pkgs; [
    google-chrome
    sops
    step-cli
    virtiofsd
    wireshark
  ];

  home-manager = {
    sharedModules = [
      {
        dconf.settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        };
        services.mpris-proxy.enable = true;
        systemd.user.tmpfiles.rules = [
          "L %h/Documents/Obsidian - - - - /sync/Obsidian"
        ];
      }
    ];
    users.vini = {
      home.packages = with pkgs; [
        beekeeper-studio
        bitwarden-desktop
        httpie
        httpie-desktop
        nautilus
        neovide
        obs-studio
        obsidian
        pcsx2
        pwvucontrol
        slack
        webcord
      ];
      programs = {
        firefox.enable = true;
        git.signing = {
          signByDefault = true;
          key = "AD3ED787366ACED9";
        };
        vscode.enable = true;
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General.Experimental = true;
    };
  };

  programs = {
    seahorse.enable = true;
    virt-manager.enable = true;
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
    oci-containers.backend = "docker";
  };

  system.stateVersion = "23.11";
}
