{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "nix-autobahn";
  version = "74b45f936935433d3f8cc03be37b2ccf70f32a37";
  src = fetchFromGitHub {
    owner = "Lassulus";
    repo = "nix-autobahn";
    rev = version;
    sha256 = "09ymq41lga7sdjd7j59njr9ld49fm8hbnn5i0bn1c73471y9wma3";
    fetchSubmodules = false;
  };
  installPhase = ''
    mkdir -p $out/bin
    mv nix-autobahn* $out/bin
  '';
}

