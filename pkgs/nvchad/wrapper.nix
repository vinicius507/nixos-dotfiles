{
  lib,
  runCommand,
  lndir,
}: nvchad: {
  appName ? "nvchad",
  custom,
  extraPackages ? [],
  gcc,
  gnumake,
  neovim,
  neovimUtils,
  ripgrep,
  wrapNeovim,
}: let
  nvchadWithCustom = runCommand "nvchad-custom" {} ''
    mkdir -p $out/nvchad
    ${lndir}/bin/lndir -silent ${nvchad} $out/nvchad
    ${lndir}/bin/lndir -silent ${custom} $out/nvchad
  '';
  nvimConfig = neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
  };
  packages = [gcc gnumake ripgrep] ++ extraPackages;
in
  wrapNeovim neovim (nvimConfig
    // {
      wrapperArgs = lib.escapeShellArgs (
        nvimConfig.wrapperArgs
        ++ ["--set" "NVIM_APPNAME" appName]
        ++ ["--set" "VIMINIT" "set rtp^=${nvchadWithCustom}/nvchad | source ${nvchadWithCustom}/nvchad/init.lua"]
        ++ ["--suffix" "PATH" ":" "${lib.makeBinPath packages}"]
      );
      wrapRc = false;
    })
