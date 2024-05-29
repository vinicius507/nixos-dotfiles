{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "memos-cli";
  version = "0.1.1";
  src = fetchFromGitHub {
    owner = "vinicius507";
    repo = "memos-cli";
    rev = "v${version}";
    sha256 = "sha256-KxVpN3ReFkT+3tm9iha/tuCWe4g+Xp4yndqpRgsjd5U=";
  };
  vendorHash = "sha256-du7r9qNu0pNZgQfpMp+YQCl7iayUkxm5FdSAsGZ0DPI=";
  installPhase = ''
    install -Dm755 $GOPATH/bin/memos-cli $out/bin/memos
  '';
  meta = with lib; {
    mainProgram = "memos";
    description = "A CLI for managing Memos";
    homepage = "https://github.com/vinicius507/memos-cli";
    license = licenses.mit;
  };
}
