{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "firefox-vertical-tabs";
  version = "6.5";
  src = fetchFromGitHub {
    owner = "ranmaru22";
    repo = "firefox-vertical-tabs";
    rev = "v${version}";
    hash = "sha256-DHI8QFr4z00tlS8SlWrrNymP6pRQ55YHq6ZegDx5iYk=";
  };
  installPhase = ''
    ls -l *
    mkdir -p $out
    cp $src/userChrome.css $out
  '';
  meta = with lib; {
    description = "Vertical tabs for Firefox, inspired by Edge.";
    licence = licenses.gpl3;
  };
}
