# nix-tree-sitter-language-pack

[![CI](https://github.com/pr0d1r2/nix-tree-sitter-language-pack/actions/workflows/ci.yml/badge.svg)](https://github.com/pr0d1r2/nix-tree-sitter-language-pack/actions/workflows/ci.yml)

Nix package for [tree-sitter-language-pack](https://github.com/kreuzberg-dev/tree-sitter-language-pack) — pre-compiled tree-sitter grammars for 305 programming languages. Pre-built binaries served via [cachix](https://pr0d1r2.cachix.org).

Backport of version 1.8.1 (nixpkgs ships 0.10.0, but semble and other tools require >=1.0).

## Usage

### As a flake input

```nix
{
  inputs.nix-tree-sitter-language-pack = {
    url = "github:pr0d1r2/nix-tree-sitter-language-pack";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # In devShell packages or Python overlay:
  nix-tree-sitter-language-pack.packages.${system}.default
}
```

## Binary cache

tree-sitter-language-pack is cached via [cachix](https://pr0d1r2.cachix.org). The flake includes `nixConfig` with the substituter, so `nix build` pulls pre-built binaries instead of compiling.

To accept the cache without prompts, add to `~/.config/nix/nix.conf`:

```ini
trusted-substituters = https://pr0d1r2.cachix.org
trusted-public-keys = pr0d1r2.cachix.org-1:NfWjbhgAj41byXhCKiaE+av3Vnphm1fTezHXEGsiQIM=
```

## License

MIT
