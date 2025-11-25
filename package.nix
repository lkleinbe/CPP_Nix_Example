{ lib, stdenv, cmake, clang, boost, ninja, enableTests ? true }:

stdenv.mkDerivation {
  # when changing this package name you might also want to change/add a default executable
  name = "package-name";
  src = lib.sourceByRegex ./. [ "^src.*" "^test.*" "CMakeLists.txt" ];

  nativeBuildInputs = [ cmake ninja boost clang ]; # compile time
  buildInputs = [ boost ]; # run time
  checkInputs = [ boost ]; # testpackages

  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";

  configurePhase = ''
    cmake -S . -B build -G Ninja
  '';

  buildPhase = ''
    # runHook preBuild
    ninja -C build
    # runHook postBuild
  '';

  checkPhase = ''
    ninja -C build test
  '';

  installPhase = ''
    install -Dm755 build/src/hello_world $out/bin/hello_world
  '';
}
