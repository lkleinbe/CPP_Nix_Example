{ lib, stdenv, pkgs, pythonEnv, pythonEnvDev }:

stdenv.mkDerivation {
  # when changing this package name you might also want to change/add a default executable
  name = "package-name";
  src = lib.sourceByRegex ./. [
    "^src_cpp.*"
    "^src_py.*"
    "^test_cpp.*"
    "^test_py.*"
    "CMakeLists.txt"
    "CMakePresets.json"
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    boost
    clang
    makeWrapper
    catch2_3
  ]; # compile time
  buildInputs = with pkgs; [ boost pythonEnv ];
  checkInputs = with pkgs; [ catch2_3 pythonEnvDev ]; # testpackages

  doCheck = true;
  # cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";

  configurePhase = ''
    cmake --preset release
  '';

  buildPhase = ''
    cmake --build --preset release
  '';

  checkPhase = ''
    ctest --preset release
    pytest
  '';

  installPhase = ''
    # Install C++ binary
    install -Dm755 build/release/src_cpp/hello_world $out/bin/hello_world

    # Install py binary
    mkdir -p $out/lib/python
    cp -r src_py $out/lib/python/
    makeWrapper ${pythonEnv}/bin/python $out/bin/hello-world-py \
      --prefix PYTHONPATH : $out/lib/python \
      --add-flags "-m src_py.hello_world"
  '';

  # Common environment variables shared between build and devShell
  passthru.commonEnv = {
    # Add your shared environment variables here
    # Example: PROJECT_ROOT = toString ./.;
  };
}
