{
  inputs = {
    # TODO: update to latest stable when 23.11 launches
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
    stylix.url = "https://flakehub.com/f/danth/stylix/0.1.269.tar.gz";
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
  in {
    packages.${system} = import ./pkgs {inherit outputs pkgs;};
    overlays = {
      nvchad = final: prev: {
        nvchad = self.packages.${final.system}.nvchad;
        nvchadUtils = self.packages.${final.system}.nvchadUtils;
      };
      hyprland = final: prev: {
        waylandUtils = self.packages.${final.system}.waylandUtils;
      };
    };
    nixosModules = import ./nixos-modules;
    nixosConfigurations = {
      nixosVm = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          self.nixosModules.base
          self.nixosModules.hyprland
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
