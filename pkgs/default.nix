{
  outputs,
  pkgs,
}: {
  memos-cli = import ./memos-cli.nix {
    inherit (pkgs) lib buildGoModule fetchFromGitHub;
  };

  rofi-run = import ./rofi-run.nix {
    inherit (pkgs) writeShellScriptBin;
  };

  wl-screenshot = import ./wl-screenshot.nix {
    inherit (pkgs) lib grim libnotify slurp wl-clipboard writeShellScriptBin;
  };

  zellij-edit = import ./zellij-edit.nix {
    inherit (pkgs) lib fd gum writeText writeShellScriptBin;
  };
}
