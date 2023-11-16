{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "nvchad";
  version = "2.0.0";
  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "refs/heads/v2.0";
    sha256 = "sha256-SG3pJIkFu/AhNqh07F+Ab0VgOBF2VxdkrxZwk7lepyg=";
  };
  installPhase = ''
    mkdir -p $out
    cp -r * "$out/"
  '';
  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    license = licenses.gpl3;
  };
}
