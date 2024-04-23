{writeShellScriptBin}:
writeShellScriptBin "rofi-run" ''
  rofi -show run -theme-str 'inputbar { background-color: @background; children: [ textbox-prompt-run, entry ]; } mainbox { children: [ inputbar ]; }'
''
