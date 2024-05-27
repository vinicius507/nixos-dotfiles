{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.glance;
  inherit (lib.generators) toYAML;
in {
  options.services.glance = {
    enable = lib.mkEnableOption "glance";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.glance;
      description = "The glance package to use.";
    };
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "The settings for the dashboard.";
    };
    finalConfigPackage = lib.mkOption {
      type = lib.types.package;
      visible = false;
      readOnly = true;
      description = "The final configuration for the dashboard.";
    };
  };
  config = lib.mkIf cfg.enable {
    services.glance.finalConfigPackage = pkgs.writeTextFile {
      name = "glance.yml";
      text = toYAML {} cfg.settings;
    };
    systemd.services.glance = {
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      description = "A dashboard that puts all your feeds in one place.";
      serviceConfig = {
        Type = "simple";
        DynamicUser = true;
        ExecStart = "${lib.getExe cfg.package} -config ${cfg.finalConfigPackage}";
        LoadCredential = "";
        Restart = "on-failure";
      };
    };
  };
}
