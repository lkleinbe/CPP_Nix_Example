{ lib,
stdenv,
cmake,
boost,
clang,
ninja,
enableTests ? true
}:

stdenv.mkDerivation{
  # when changing this package name you might also want to change/add a default executable
  name = "package-name";
  src = lib.sourceByRegex ./. [
    "^src.*"
    "^test.*"
    "CMakeLists.txt"
  ];

  nativeBuildInputs = [cmake ninja]; #compile time
  buildInputs = [boost]; # run time
  checkInputs = [boost]; #testpackages

  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";
}
