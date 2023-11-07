{
  base = import ./base.nix;
  vm = {
    virtualisation.vmVariant = {
      virtualisation.cores = 2;
      virtualisation.graphics = false;
      virtualisation.memorySize = 2048;
    };
  };
}
