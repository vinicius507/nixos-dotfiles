{outputs, ...}: {
  neovim-config = final: prev: {
    neovim-config = outputs.packages.${final.system}.neovim-config;
  };
  rofi-run = final: prev: {
    rofi-run = outputs.packages.${final.system}.rofi-run;
  };
  wl-screenshot = final: prev: {
    wl-screenshot = outputs.packages.${final.system}.wl-screenshot;
  };
}
