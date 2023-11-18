{config, ...}: let
  inherit (config.gtk) iconTheme;
in {
  services.mako = {
    enable = true;
    anchor = "bottom-right";
    width = 300;
    height = 150;
    margin = "16,16";
    padding = "8";
    borderSize = 2;
    borderRadius = 2;
    iconPath = "${iconTheme.package}/share/icons/${iconTheme.name}";
    maxIconSize = 48;
    defaultTimeout = 5000;
  };
}
