{
  outputs,
  pkgs,
}: {
  rofi-run = import ./rofi-run.nix {
    inherit (pkgs) writeShellScriptBin;
  };

  neovim-config = pkgs.stdenvNoCC.mkDerivation {
    name = "neovim-config";
    src = ./neovim-config;
    dontBuild = true;
    installPhase = ''
      cp -r $src $out
    '';
  };

  wl-screenshot = import ./wl-screenshot.nix {
    inherit (pkgs) lib grim libnotify slurp wl-clipboard writeShellScriptBin;
  };

  zellij-edit = import ./zellij-edit.nix {
    inherit (pkgs) lib fd gum writeText writeShellScriptBin;
  };
}
