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
      settings = {
        "browser.startup.homepage" = "https://dezano.io";
        "extensions.bitwarden.enabled" = true;
        "extensions.darkreader.enabled" = true;
        "extensions.tabcenter-reborn.enabled" = true;
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
        ublock-origin
      ];
      search = {
        force = true;
        engines = {
          "Docker Hub" = {
            definedAliases = ["@dh"];
            updateInterval = 24 * 60 * 60 * 1000;
            iconUpdateURL = "https://hub.docker.com/favicon.ico";
            urls = [
              {
                template = "https://hub.docker.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          "Github" = {
            definedAliases = ["@gh"];
            updateInterval = 24 * 60 * 60 * 1000;
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.svg";
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          "Nix Packages" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          "Nix Options" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
  stylix.targets.firefox.profileNames = ["default"];
}
