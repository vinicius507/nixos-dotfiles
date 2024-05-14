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

  entertainment.steam.enable = true;

  networking.hostName = "minipc";
  networking.networkmanager.wifi.powersave = false;

  nixpkgs.config.allowUnfree = true;

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

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}
