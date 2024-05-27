{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "memos-cli";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "vinicius507";
    repo = "memos-cli";
    rev = "4e73281efd8113f6d356b9a6dbd2f95a116d150e";
    sha256 = "sha256-ULuLp4TqK4rFfO0f79+8h1ewLicREz3Vp/TG3ZJW3GY=";
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
