{
  base = import ./base.nix;
  hyprland = import ./hyprland.nix;
  vm = {
    security.sudo.wheelNeedsPassword = false;
    virtualisation.vmVariant = {
      virtualisation.cores = 2;
      virtualisation.memorySize = 2048;
      virtualisation.qemu.options = [
        "-device virtio-vga-gl"
        "-display sdl,gl=on,show-cursor=off"
        "-audio pa,model=hda"
      ];
    };
  };
}
