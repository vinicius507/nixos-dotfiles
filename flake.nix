{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/*.tar.gz";
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/*.tar.gz";
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/*.tar.gz";
    stylix.url = "https://flakehub.com/f/danth/stylix/=0.1.285.tar.gz";
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
        zellijUtils = self.packages.${final.system}.zellijUtils;
      };
      hyprland = final: prev: {
        rofiUtils = self.packages.${final.system}.rofiUtils;
        waylandUtils = self.packages.${final.system}.waylandUtils;
      };
    };
    nixosModules = import ./nixos-modules;
    nixosConfigurations = {
      desktop = mkHost [
        ./hosts/desktop
        self.nixosModules.gaming
        self.nixosModules.hyprland
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
        helix
      ];
      NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    };
  };
}
