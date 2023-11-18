{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/*.tar.gz";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = builtins.attrValues self.overlays;
    };
  in {
    packages.${system} = {
      nixosVm = self.nixosConfigurations.nixosVm.config.system.build.vm;
      nvchad = import ./pkgs/nvchad {
        inherit (pkgs) lib stdenv fetchFromGitHub;
      };
      nvchadUtils = {
        wrapNvchad = import ./pkgs/nvchad/wrapper.nix {
          inherit (pkgs) lib runCommand;
          inherit (pkgs.xorg) lndir;
        };
      };
    };
    overlays = {
      nvchad = final: prev: {
        nvchad = self.packages.${final.system}.nvchad;
        nvchadUtils = self.packages.${final.system}.nvchadUtils;
      };
    };
    nixosModules = import ./nixos-modules;
    nixosConfigurations = {
      nixosVm = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          self.nixosModules.base
          self.nixosModules.vm
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };
    homeManagerModules = import ./hm-modules;
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nix
        git
        helix
      ];
      NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    };
  };
}
