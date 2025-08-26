{ lib, stdenv, cmake, boost, clang, ninja, enableTests ? true }:

stdenv.mkDerivation {
  # when changing this package name you might also want to change/add a default executable
  name = "package-name";
  src = lib.sourceByRegex ./. [ "^src.*" "^test.*" "CMakeLists.txt" ];

  nativeBuildInputs = [ cmake ninja ]; # compile time
  buildInputs = [ boost ]; # run time
  checkInputs = [ boost ]; # testpackages

  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";

  cmakePhase = ''
    cmake -S . -B build -G Ninja
  '';

  buildPhase = ''
    ninja -C build
  '';

  checkPhase = ''
    ninja -C build test
  '';

  installPhase = ''
    install -DM755 build/hello_world $out/bin/hello_world
  '';
}
