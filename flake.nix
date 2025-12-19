{
  description = "CPP and Python Development Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, lib, ... }:
        let
          # Python venv
          workspace =
            inputs.uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };
          overlay =
            workspace.mkPyprojectOverlay { sourcePreference = "wheel"; };
          uvBuildOverlay = final: prev: {
            uv_build = pkgs.python313Packages.uv-build;
          };
          python = pkgs.python313;
          pythonSet = (pkgs.callPackage inputs.pyproject-nix.build.packages {
            inherit python;
          }).overrideScope (lib.composeManyExtensions [
            inputs.pyproject-build-systems.overlays.default
            uvBuildOverlay
            overlay
          ]);
          venv =
            pythonSet.mkVirtualEnv "hello-world-py-env" workspace.deps.default;

          # Extra Venv for python development dependencies
          editableOverlay =
            workspace.mkEditablePyprojectOverlay { root = "$REPO_ROOT"; };
          pythonSetDev = pythonSet.overrideScope editableOverlay;
          venvDev = pythonSetDev.mkVirtualEnv "hello-world-py-dev-env"
            workspace.deps.all;

        in {
          packages = {
            default = pkgs.callPackage ./package.nix { pythonEnv = venv; };
          };

          # default app will be importet and run.
          apps = {
            default = {
              type = "app";
              program = "${config.packages.default}/bin/hello_world";
            };
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.packages.default ];
            packages = [ pkgs.uv venvDev ];
            env = config.packages.default.passthru.commonEnv // {
              UV_NO_SYNC = "1";
              UV_PYTHON = pythonSetDev.python.interpreter;
              UV_PYTHON_DOWNLOADS = "never";
            };
            shellHook = ''
              unset PYTHONPATH
              export REPO_ROOT=$(pwd)
            '';
          };
        };
    };
}

