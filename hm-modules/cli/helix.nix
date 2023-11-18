{pkgs, ...}: {
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
          language-servers = ["nil"];
        }
      ];
      language-server = {
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
      };
    };
    themes.custom = {
      inherits = "catppuccin_mocha";
      "ui.background" = {};
      "ui.help" = {fg = "overlay2";};
      "ui.highlight" = {fg = "teal";};
      "ui.popup" = {};
      "ui.menu.selected" = {
        fg = "teal";
        bg = "surface1";
        modifiers = ["bold"];
      };
      "ui.statusline" = {};
      "ui.statusline.inactive" = {fg = "surface2";};
    };
    settings = {
      theme = "custom";
      editor = {
        color-modes = true;
        cursor-shape.insert = "bar";
        cursor-shape.select = "underline";
        indent-guides.render = true;
        indent-guides.skip-levels = 1;
        line-number = "relative";
        soft-wrap.enable = true;
        lsp.display-messages = true;
        lsp.display-inlay-hints = true;
        statusline.mode = {
          normal = "N";
          insert = "I";
          select = "S";
        };
      };
      keys.normal.space = {
        l = ":toggle lsp.display-inlay-hints";
        G = ":sh zellij run --floating --close-on-exit -- lazygit";
      };
    };
  };
  stylix.targets.helix.enable = false;
}
