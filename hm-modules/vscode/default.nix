{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      catppuccin.catppuccin-vsc
      github.copilot
      ms-vsliveshare.vsliveshare
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
    userSettings = {
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.workbenchMode" = "flat";
    };
    keybindings = [
      {
        key = "ctrl+'";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
  stylix.targets.vscode.enable = false;
}
