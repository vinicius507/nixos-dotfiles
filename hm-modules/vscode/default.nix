{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      catppuccin.catppuccin-vsc
      github.copilot
      ms-vscode-remote.remote-containers
      ms-vsliveshare.vsliveshare
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
    userSettings = {
      "editor.minimap.enabled" = false;
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.workbenchMode" = "flat";
      "dev.containers.defaultExtensions" = [
        "GitHub.copilot"
        "ms-vsliveshare.vsliveshare"
      ];
    };
    keybindings = [
      {
        key = "ctrl+'";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
  home.file.".vscode/argv.json".text = builtins.toJSON {
    password-store = "gnome";
  };
  stylix.targets.vscode.enable = false;
}
