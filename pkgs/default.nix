{
  outputs,
  pkgs,
}: {
  nixosVm = outputs.nixosConfigurations.nixosVm.config.system.build.vm;
  rofiUtils = {
    run = import ./rofiUtils/run.nix {
      inherit (pkgs) writeShellScriptBin;
    };
  };
  waylandUtils = {
    screenshot = import ./waylandUtils/screenshot.nix {
      inherit (pkgs) lib grim libnotify slurp wl-clipboard writeShellScriptBin;
    };
  };
  zellijUtils = {
    edit = import ./zellijUtils/edit.nix {
      inherit (pkgs) lib fd gum writeText writeShellScriptBin;
    };
  };
}
