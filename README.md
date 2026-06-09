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

### Substituting the hello_world submodule

Remove the existing submodule and add your own in its place:

```
git submodule deinit hello_world
git rm hello_world
rm -rf .git/modules/hello_world
git submodule add <url> hello_world
git submodule update --init
```

Then update `flake.nix` if the Python workspace layout differs, and adjust the build/install paths in `package.nix` to match your project's CMake output.

### Removing the hello_world submodule entirely

```
git submodule deinit hello_world
git rm hello_world
rm -rf .git/modules/hello_world
```

Remove the `workspace`, `venv`, and Python-related blocks from `flake.nix`, and strip `package.nix` down to just the C++ build.

### Adding an additional submodule

```
git submodule add <url> <path>
```

If the new submodule has its own Python workspace, add a corresponding `workspace`/`venv` block in `flake.nix` following the existing pattern.
