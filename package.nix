{ lib,
stdenv,
cmake,
boost,
clang,
ninja,
enableTests ? true
}:

stdenv.mkDerivation{
  name = "package-name";
  src = lib.sourceByRegex ./. [
    "^src.*"
    "^test.*"
    "CMakeLists.txt"
  ];

  nativeBuildInputs = [cmake ninja]; #compile time
  buildInputs = [boost ninja]; # run time
  checkInputs = []; #testpackages

  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";
}
