# SPEC — nix-tree-sitter-language-pack

## §G GOAL

Standalone Nix package for [tree-sitter-language-pack](https://github.com/kreuzberg-dev/tree-sitter-language-pack) v1.8.1 — pre-compiled tree-sitter grammars for 305 languages. Backport: nixpkgs ships 0.10.0, semble needs >=1.0. Uses pre-built PyPI wheels (maturin/Rust source build = 305 grammar compilations). Pre-built via cachix (`pr0d1r2.cachix.org`).

## §C CONSTRAINTS

- C1: Nix flake, pinned `nixos-25.11`
- C2: 4 systems: aarch64-darwin, x86_64-darwin, x86_64-linux, aarch64-linux
- C3: Fetches pre-built wheels from PyPI — no source build (maturin + 305 grammars)
- C4: Platform-specific wheel hashes per system
- C5: cp310-abi3 wheels — single wheel works for Python 3.10+
- C6: Sole dep: tree-sitter>=0.25.2 (in nixpkgs as 0.25.2)
- C7: cachix binary cache in `nixConfig`
- C8: 6 nix-lefthook inputs w/ follows deduplication
- C9: No embedded shell in nix

## §I INTERFACES

- I.pkg: `packages.<system>.default` — tree-sitter-language-pack Python package
- I.dev: `devShells.<system>.default` — dev environment w/ package + linters
- I.flake-input: `inputs.nix-tree-sitter-language-pack.url = "github:pr0d1r2/nix-tree-sitter-language-pack"`

## §V VERSIONING

- Version: pinned in tree-sitter-language-pack.nix (currently 1.8.1)
- Bump: update version + all 4 wheel hashes
- **TODO**: Wheel hashes are currently PLACEHOLDER values — must be filled in by fetching actual wheels from PyPI

## §T TESTING

- T1: `nix flake check` — evaluates package + devShell for all systems
- T2: `pythonImportsCheck` validates import
- T3: lefthook pre-commit quality gates
- T4: wheel hash integrity verified by nix fetchurl

## §B BUILD

- B1: `nix build` — fetches wheel + installs for current system
- B2: `nix develop` — enters dev shell
- B3: cachix push: `nix build && cachix push pr0d1r2 result`
