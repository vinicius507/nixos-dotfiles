{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/*.tar.gz";
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/*.tar.gz";
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/*.tar.gz";
    stylix.url = "https://flakehub.com/f/danth/stylix/=0.1.285.tar.gz";
    nur.url = "github:nix-community/NUR";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = builtins.attrValues self.overlays;
    };
    mkHost = modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [self.nixosModules.base] ++ modules;
        specialArgs = {inherit inputs outputs;};
      };
  in {
    packages.${system} = import ./pkgs {inherit outputs pkgs;};
    overlays = {
      base = final: prev: {
        zellij-edit = self.packages.${final.system}.zellij-edit;
      };
      hyprland = final: prev: {
        firefox-vertical-tabs = self.packages.${final.system}.firefox-vertical-tabs;
        rofi-run = self.packages.${final.system}.rofi-run;
        wl-screenshot = self.packages.${final.system}.wl-screenshot;
      };
    };
    nixosModules = import ./nixos-modules;
    nixosConfigurations = {
      desktop = mkHost [
        ./hosts/desktop
        self.nixosModules.gaming
        self.nixosModules.hyprland
      ];
      minipc = mkHost [
        ./hosts/minipc
        self.nixosModules.hyprland
        self.nixosModules.gaming
      ];
      nixosVm = mkHost [
        self.nixosModules.hyprland
        self.nixosModules.vm
      ];
    };
    homeManagerModules = import ./hm-modules;
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nix
        git
      ];
      shellHook = ''
        export DOTFILES_DEV=true

        if [ -z "$NVIM" ]; then
          mkdir -p /tmp/nvim-dev/config
          [ -L /tmp/nvim-dev/config/git ] && [ -e /tmp/nvim-dev/config/git ] || ln -sf $HOME/.config/git /tmp/nvim-dev/config/git
          [ -L /tmp/nvim-dev/config/fish ] && [ -e /tmp/nvim-dev/config/fish ] || ln -sf $HOME/.config/fish /tmp/nvim-dev/config/fish
          [ -L /tmp/nvim-dev/config/nvim ] && [ -e /tmp/nvim-dev/config/nvim ] || ln -sf $(git rev-parse --show-toplevel)/hm-modules/neovim/config /tmp/nvim-dev/config/nvim
        fi
      '';
      NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    };
  };
}
