{
  lib,
  pkgs,
  config,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  vscodeEnabled = config.programs.vscode.enable;
in {
  home.file.".vscode/argv.json".text = lib.mkIf vscodeEnabled (builtins.toJSON {
    password-store = "gnome";
  });
  programs.vscode = {
    extensions = with pkgs.vscode-extensions;
      [
        aaron-bond.better-comments
        catppuccin.catppuccin-vsc
        github.copilot
        jnoortheen.nix-ide
        mkhl.direnv
        ms-vscode-remote.remote-containers
        ms-vsliveshare.vsliveshare
        vscodevim.vim
        wix.vscode-import-cost
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "symbols";
          publisher = "miguelsolorio";
          version = "0.0.20";
          sha256 = "sha256-u5kwrPysf3Fn7Yn9hJg3aIq8XuK+cRtHJlvn9uGdB8U=";
        }
      ];
    userSettings = {
      "breadcrumbs.enabled" = false;
      "catppuccin.colorOverrides" = {
        mocha = {
          base = colors.base00;
          mantle = colors.base01;
          crust = colors.base00;
          surface0 = colors.base02;
          surface1 = colors.base03;
          surface2 = colors.base04;
        };
      };
      "catppuccin.workbenchMode" = "flat";
      "dev.containers.defaultExtensions" = [
        "GitHub.copilot"
        "ms-vsliveshare.vsliveshare"
      ];
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.lineHeight" = 1.8;
      "editor.minimap.enabled" = false;
      "editor.rulers" = [80 120];
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.vertical" = "hidden";
      "editor.semanticHighlighting.enabled" = true;
      "explorer.compactFolders" = false;
      "explorer.confirmDelete" = false;
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.patterns" = {
        ".env" = ".env*";
        "flake.nix" = "flake.lock";
      };
      "files.exclude" = {
        "**/.devenv" = true;
        "**/.direnv" = true;
      };
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
      "window.restoreWindows" = "none";
      "window.titleBarStyle" = "native";
      "workbench.activityBar.location" = "hidden";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.editor.labelFormat" = "short";
      "workbench.iconTheme" = "symbols";
      "workbench.layoutControl.enabled" = false;
      "workbench.startupEditor" = "none";
      "vim.leader" = "<space>";
      "vim.hlsearch" = true;
      "vim.incsearch" = true;
      "vim.useSystemClipboard" = true;
      "vim.enableNeovim" = true;
      "vim.neovimPath" = lib.getExe config.programs.neovim.finalPackage;
      "vim.neovimUseConfigFile" = true;
      "vim.handleKeys" = {
        "<C-q>" = false;
        "<C-p>" = false;
      };
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = ["K"];
          after = ["g" "h"];
        }
        {
          before = ["<leader>" "e"];
          commands = ["workbench.action.focusSideBar"];
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
        key = "escape";
        command = "workbench.action.focusLastEditorGroup";
        when = "explorerViewletVisible && filesExplorerFocus";
      }
      {
        key = "a";
        command = "explorer.newFile";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        key = "shift+a";
        command = "explorer.newFolder";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        key = "r";
        command = "renameFile";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
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
  stylix.targets.vscode.enable = false;
}
