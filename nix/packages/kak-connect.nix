{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "kak-connect";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "alexherbo2";
    repo = "connect.kak";
    rev = "56fc2476e8cf126fb16654f4a08582f4f76b0d3d";
    sha256 = "2+wKjkS5DRZN8W2xJ09pe8jH8mGV5sP4WQB0z1sG6+M=";
  };

  phases = "unpackPhase installPhase";

  installPhase = ''
    mkdir -p "$out/bin" "$out/share/kak/autoload/plugins"
    cp bin/kak-shell "$out/bin/kak-shell"
    cp -r rc "$out/share/kak/autoload/plugins/connect"
  '';
}
