{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:danth/stylix";
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
    mkHost = args:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/shared] ++ args.modules;
        specialArgs = {inherit inputs outputs;};
      };
  in {
    packages.${system} = import ./pkgs {inherit outputs pkgs;};
    overlays = import ./overlays {
      inherit outputs;
    };
    nixosConfigurations = {
      desktop = mkHost {
        modules = [
          ./hosts/desktop
        ];
      };
      minipc = mkHost {
        modules = [
          ./hosts/minipc
        ];
      };
    };
    homeManagerModules = import ./hm-modules;
    homeConfigurations = import ./home;
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
