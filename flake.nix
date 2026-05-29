{
  description = "Nix package for tree-sitter-language-pack — pre-compiled grammars for 305 languages";

  nixConfig = {
    extra-substituters = [ "https://pr0d1r2.cachix.org" ];
    extra-trusted-public-keys = [ "pr0d1r2.cachix.org-1:NfWjbhgAj41byXhCKiaE+av3Vnphm1fTezHXEGsiQIM=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-lefthook = {
      url = "github:pr0d1r2/nix-lefthook";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-lefthook,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = import ./tree-sitter-language-pack.nix { inherit pkgs; };
      });

      devShells = forAllSystems (pkgs: {
        ci = pkgs.mkShell {
          inputsFrom = [ nix-lefthook.devShells.${pkgs.stdenv.hostPlatform.system}.ci ];
          packages = [
            (import ./tree-sitter-language-pack.nix { inherit pkgs; })
          ];
        };

        default = pkgs.mkShell {
          inputsFrom = [ nix-lefthook.devShells.${pkgs.stdenv.hostPlatform.system}.ci ];
          packages = [
            (import ./tree-sitter-language-pack.nix { inherit pkgs; })
          ];
          shellHook = builtins.readFile ./dev.sh;
        };
      });
    };
}
