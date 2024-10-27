{
  outputs,
  pkgs,
}: {
  rofi-run = import ./rofi-run.nix {
    inherit (pkgs) writeShellScriptBin;
  };

  wl-screenshot = import ./wl-screenshot.nix {
    inherit (pkgs) lib grim libnotify slurp wl-clipboard writeShellScriptBin;
  };
}
