{pkgs, ...}: let
  zellijEditLayout = pkgs.writeText "edit.kdl" ''
    layout {
      pane command="$SHELL" close_on_exit=true {
        args "-ic" "$EDITOR $(${pkgs.fzf}/bin/fzf); exec $SHELL"
      }
      pane size=1 borderless=true {
        plugin location="zellij:compact-bar"
      }
    }
  '';
in {
  programs.fish.shellAliases.edit = "${pkgs.zellij}/bin/zellij --layout ${zellijEditLayout}";
  programs.zellij = {
    settings = {
      default_layout = "compact";
    };
  };
}
