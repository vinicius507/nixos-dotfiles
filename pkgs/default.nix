{
  outputs,
  pkgs,
}: {
  nixosVm = outputs.nixosConfigurations.nixosVm.config.system.build.vm;

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
