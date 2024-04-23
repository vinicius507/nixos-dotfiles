{
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (inputs) nur;
in {
  imports = [
    nur.hmModules.nur
  ];
  home.file.firefox-vertical-tabs = {
    target = ".mozilla/firefox/default/chrome/firefox-vertical-tabs";
    source = pkgs.firefox-vertical-tabs;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisableTelemetry = true;
      };
    };
    profiles.default = {
      id = 0;
      name = "Dezano";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
      };
      userChrome = ''
        @import url('firefox-vertical-tabs/userChrome.css');
      '';
      extensions = with config.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        tabcenter-reborn
      ];
    };
  };
}
