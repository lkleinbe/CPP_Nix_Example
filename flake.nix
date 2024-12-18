{
  description = "CPP Development Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = inputs@{ flake-parts, ...}:flake-parts.lib.mkFlake {inherit inputs; }{
    systems = [
      "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"
    ];
    perSystem = {config, self', inputs', pkgs, system, ...}:{
      packages = {
        default = pkgs.callPackage ./package.nix {stdenv = pkgs.clangStdenv;};
      };
      checks = config.packages //{
        clang = config.packages.default.override{
          stdenv = pkgs.clangStdenv;
        };
      };
    };
  };
}


