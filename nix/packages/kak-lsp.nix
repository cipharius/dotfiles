{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "kak-lsp";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "kak-lsp";
    repo = "kak-lsp";
    rev = "v${version}";
    sha256 = "sha256-NfEwTFeOwmi0Vkgwgk4tB3Z7jPw+yhqno5Dv+HUoalo=";
  };

  installPhase = ''
    ls
  '';
}
