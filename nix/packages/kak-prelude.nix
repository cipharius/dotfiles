{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "kak-prelude";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "alexherbo2";
    repo = "prelude.kak";
    rev = "f1e0f4d5cb62a36924e3f8ba6824d6aed8c19d23";
    sha256 = "DNHORL++3Pw+Qt+jqTZDjbqkw0WGwb99+oJu/BXKzN4=";
  };

  phases = "unpackPhase installPhase";

  installPhase = ''
    mkdir -p "$out/bin" "$out/share/kak/autoload/plugins"
    cp -r rc "$out/share/kak/autoload/plugins/prelude"
  '';
}
