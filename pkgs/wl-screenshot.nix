{
  lib,
  grim,
  libnotify,
  slurp,
  wl-clipboard,
  writeShellScriptBin,
}:
writeShellScriptBin "screenshot" ''
  MODE=$1
  SHOT="$HOME/Pictures/Screenshots/$(date +%F_%T | sed 's/:/-/g').png"

  if [ "$MODE" == "full" ]; then
      # take a screenshot of the entire screen
      ${lib.getExe grim} $SHOT
  elif [ "$MODE" == "section" ]; then
      # select a section of the screen to capture
      area=$(${lib.getExe slurp})
      ${lib.getExe grim} -g "$area" "$SHOT"
  else
      echo "Usage: $0 [full|section]"
      exit 1
  fi

  if [ -f "$SHOT" ]; then
    ${wl-clipboard}/bin/wl-copy < "$SHOT"
    ${libnotify}/bin/notify-send "Screenshot" "The screenshot has been copied to the clipboard."
  fi
''
