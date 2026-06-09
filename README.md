# My personal Nix Flake template for CPP projects

This project can be used for 
- small examples 
- code tests
- experiments for the code editor.

## Build

```
cmake --preset debug
cmake --build --preset debug
```

## Submodules

### Initializing after clone

```
git submodule update --init
```

### Removing the hello_world submodule entirely

```
git submodule deinit hello_world
git rm hello_world
rm -rf .git/modules/hello_world
```

Remove the `workspace`, `venv`, and Python-related blocks from `flake.nix`, and strip `package.nix` down to just the C++ build.

### Adding an additional submodule

```
git submodule add <url> 
```

When substituting hello_world update `flake.nix` if the Python workspace layout differs, and adjust the build/install paths in `package.nix` to match your project's CMake output.

When just adding a new submodule and if the new submodule has its own Python workspace, add a corresponding `workspace`/`venv` block in `flake.nix` following the existing pattern.
