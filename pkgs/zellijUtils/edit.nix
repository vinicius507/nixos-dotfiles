{
  lib,
  fd,
  gum,
  writeText,
  writeShellScriptBin,
}: let
  gumFilter = placeholder: "${lib.getExe gum} filter --no-strict --placeholder='${placeholder}'";
  layoutFile = writeText "edit.kdl" ''
    layout {
      pane command="$SHELL" close_on_exit=true {
        args "-ic" "$EDITOR $(${lib.getExe fd} . | ${gumFilter "Edit..."}); exec $SHELL"
      }
      pane size=1 borderless=true {
        plugin location="zellij:compact-bar"
      }
    }
  '';
in
  writeShellScriptBin "edit" ''
    if [ -z "$ZELLIJ" ]; then
      zellij --layout ${layoutFile} "$@"
    else
      FILE=$(${lib.getExe fd} . | ${gumFilter "Edit in current session..."})
      $EDITOR $FILE
    fi
  ''
