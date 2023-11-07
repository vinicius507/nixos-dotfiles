{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };
  outputs = {
    self,
    nixpkgs,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      nixosVm = self.nixosConfigurations.nixosVm.config.system.build.vm;
    };
    nixosModules = import ./nixos-modules;
    nixosConfigurations = {
      nixosVm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          self.nixosModules.base
          self.nixosModules.vm
        ];
        specialArgs = {inherit inputs;};
      };
    };
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
