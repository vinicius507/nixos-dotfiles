{outputs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  home-manager.users.vini.imports = [
    outputs.homeManagerModules.hyprland
  ];
}
