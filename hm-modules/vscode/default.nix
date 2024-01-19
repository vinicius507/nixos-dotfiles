{
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        catppuccin.catppuccin-vsc
        github.copilot
        jnoortheen.nix-ide
        mkhl.direnv
        ms-vscode-remote.remote-containers
        ms-vsliveshare.vsliveshare
        vscodevim.vim
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "symbols";
          publisher = "miguelsolorio";
          version = "0.0.16";
          sha256 = "sha256-LGCeqleDGWveJ7KPYd6+ArynEpET4xrhvI2H4NPuCtQ=";
        }
      ];
    userSettings = {
      "breadcrumbs.enabled" = false;
      "catppuccin.workbenchMode" = "flat";
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 1.8;
      "editor.minimap.enabled" = false;
      "editor.rulers" = [80 120];
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollbar.horizontal" = "hidden";
      "editor.semanticHighlighting.enabled" = true;
      "explorer.compactFolders" = false;
      "explorer.fileNesting.enabled" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = lib.getExe pkgs.nil;
      "nix.serverSettings" = {
        nil.formatting.command = [
          "${lib.getExe pkgs.alejandra}"
        ];
      };
      "symbols.hidesExplorerArrows" = false;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.commandCenter" = false;
      "window.menuBarVisibility" = "toggle";
      "window.restoreWindows" = false;
      "window.titleBarStyle" = "native";
      "workbench.activityBar.location" = "hidden";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.editor.labelFormat" = "short";
      "workbench.iconTheme" = "symbols";
      "workbench.layoutControl.enabled" = false;
      "workbench.startupEditor" = "none";
      "dev.containers.defaultExtensions" = [
        "GitHub.copilot"
        "ms-vsliveshare.vsliveshare"
      ];
      "vim.leader" = "<space>";
      "vim.hlsearch" = true;
      "vim.incsearch" = true;
      "vim.useSystemClipboard" = true;
      "vim.enableNeovim" = true;
      "vim.neovimPath" = lib.getExe pkgs.neovim;
      "vim.handleKeys" = {"<C-q>" = false;};
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = ["p"];
          after = ["p" "g" "v" "y"];
        }
        {
          before = ["K"];
          after = ["g" "h"];
        }
        {
          before = ["<leader>" "e"];
          commands = ["workbench.action.focusSidebar"];
        }
        {
          before = ["<leader>" "f" "f"];
          commands = ["workbench.action.quickOpen"];
        }
        {
          before = ["<leader>" "w" "v"];
          commands = ["workbench.action.splitEditor"];
        }
        {
          before = ["<leader>" "w" "s"];
          commands = ["workbench.action.splitEditorDown"];
        }
      ];
      "vim.visualModeKeyBindings" = [
        {
          before = [">"];
          commands = ["editor.action.indentLines"];
        }
        {
          before = ["<"];
          commands = ["editor.action.outdentLines"];
        }
      ];
      "extensions.experimental.affinity" = {
        "vscodevim.vim" = 1;
      };
    };
    keybindings = [
      {
        key = "ctrl+/";
        command = "workbench.action.terminal.toggleTerminal";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.focusLeftGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.focusBelowGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.focusAboveGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.focusRightGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = ", e";
        command = "workbench.action.focusLastEditorGroup";
        when = "!editorTextFocus";
      }
      {
        key = ", t";
        command = "workbench.action.toggleSidebarVisibility";
        when = "!editorTextFocus";
      }
      {
        key = "r";
        command = "renameFile";
        when = "explorerViewletVisible && filesExplorerFocus";
      }
      {
        key = "tab";
        command = "selectNextSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "shift+tab";
        command = "selectPrevSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.quickOpenSelectNext";
        when = "inQuickOpen";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.quickOpenSelectPrevious";
        when = "inQuickOpen";
      }
      {
        key = "ctrl+q";
        command = "-workbench.action.quit";
      }
      {
        key = "ctrl+q";
        command = "workbench.action.quickOpenView";
      }
    ];
  };
  home.file.".vscode/argv.json".text = builtins.toJSON {
    password-store = "gnome";
  };
  stylix.targets.vscode.enable = false;
}
